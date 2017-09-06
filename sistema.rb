def read_file(file_name)
  file = File.open(file_name, "r")
  alumnos = file.readlines.map(&:chomp).map{ |ele| ele.split(', ')}
  file.close
  return alumnos
end

def prom(array)
  sum = 0
  str_sum = 0 
  array.each do |ele|
    unless ele.to_i == 0
      sum += ele.to_i
    else
      str_sum+=1        
    end
  end   
  return sum / (array.length.to_f - str_sum)
end

def inasis(array)
  str_sum = 0 
  array.each do |ele|
    if ele.to_i == 0
      str_sum+=1        
    end
  end   
  return str_sum
end


def add_alumno(file_name)
  alumnos = read_file(file_name)
  # p alumnos
  alumnos.each do |alumno| 
    nombre_alumno = alumno.shift
    promedio = prom(alumno)
    File.open("promedios.txt", "a") { |f| 
		  f.puts "#{nombre_alumno}: su promedio es #{promedio}" }
  end
  return nil
end


def inasistentes(file_name)
  alumnos = read_file(file_name)
  alumnos.each do |alumno| 
    nombre_alumno = alumno.shift
    inasistencias = inasis(alumno)
    puts "El alumno #{nombre_alumno} tuvo un total de #{inasistencias} inasistencias."
  end
end

def aprobados(file_name, nota=5)
  alumnos = read_file(file_name)
  alumnos.each do |alumno| 
    nombre_alumno = alumno.shift
    promedio = prom(alumno)
    if promedio > nota
      puts "El alumno #{nombre_alumno} ha aprobado con nota #{promedio}"
    end
  end
end

puts 'Sistema de Alumnos'
puts  'press enter'

option = gets.chomp

while option != '4'

  puts 'Ingresa 1 para agregar a los alumnos'
  puts 'Ingresa 2 para ver las inasistencias totales'
  puts 'Ingresa 3 para ver los alumnos aprobados'
  puts 'Ingresa 4 para salir'

  option = gets.chomp
  puts case  option
    when '1'
      add_alumno("alumnos.csv")
      puts 'El archivo se ha generado!'
    when '2'
      inasistentes("alumnos.csv")
    when '3'
      puts "Ingrese nota aprobación"
      nota = gets.chomp.to_f
      if nota == 0
        aprobados("alumnos.csv")
      else
        aprobados("alumnos.csv", nota)      
      end    

    when '4' 
      puts "Te extrañaremos :'("
    else
      'Ingresa un número del 1 al 4'
    end
end