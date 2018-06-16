# Objetivo:
#   Diseñar un mini sistema para administrar un taller mecánico de vehículos. El taller puede
#   reparar motocicletas, carros, SUVs, minivans y pickups.
#
# Generar un catálogo de vehículos en taller y una historia de los que ya se han reparado, así como
# el estado en el que están los que están en proceso (recibido, en taller, por entregar, etc.)
#
# Agrega métodos relevantes para contestar las siguientes preguntas:
# - Cuántos vehículos tengo ahorita en reparación?
# - Qué tipo de vehículos he reparado más? y menos?
# - Qué año son los carros que tengo en reparación?
# - Cuántos vehículos he entregado?
# - Cuántos vehículos he tenido y tengo en total dependiendo del tipo?

class VehicleRepairShop
  attr_accessor :vehicles

  def initialize(vehicles)
    @vehicles = vehicles
  end

  def count_of_vehicles_delivered
    count = 0
    @vehicles.each do |vehicle|
      count += 1 if vehicle.status == "delivered"
    end
    count
  end

  def count_of_vehicles_in_repair
    count = 0
    @vehicles.each do |vehicle|
      count += 1 if vehicle.status == "in_repair"
    end
    count
  end

  def years_of_vehicles_in_repair
    years = []
    @vehicles.each do |vehicle|
      years.push(vehicle.year) if vehicle.status == "in_repair"
    end
    years
  end

  def most_repaired_vehicles
    counters = {
      car: 0,
      motorcycle: 0,
      suv: 0,
      pickuptruck: 0,
      minivan: 0
    }
    @vehicles.each do |vehicle|
      if vehicle.status == "delivered"
        counters[:car] += 1 if vehicle.is_a?(Car)
        counters[:motorcycle] += 1 if vehicle.is_a?(Motorcycle)
        counters[:suv] += 1 if vehicle.is_a?(SUV)
        counters[:pickuptruck] += 1 if vehicle.is_a?(PickUpTruck)
        counters[:minivan] += 1 if vehicle.is_a?(Minivan)
      end
    end

    biggest_count = 0
    biggest_type = nil
    counters.each do |type, count|
      if count > biggest_count
        biggest_count = count
        biggest_type = type
      end
    end
    biggest_type
  end

  def count_of_vehicles_by_type
    counters = {
      car: 0,
      motorcycle: 0,
      suv: 0,
      pickuptruck: 0,
      minivan: 0
    }
    @vehicles.each do |vehicle|
      counters[:car] += 1 if vehicle.is_a?(Car)
      counters[:motorcycle] += 1 if vehicle.is_a?(Motorcycle)
      counters[:suv] += 1 if vehicle.is_a?(SUV)
      counters[:pickuptruck] += 1 if vehicle.is_a?(PickUpTruck)
      counters[:minivan] += 1 if vehicle.is_a?(Minivan)
    end
    counters
  end
end

class Vehicle
  attr_accessor :make
  attr_accessor :model
  attr_accessor :year
  attr_accessor :color
  attr_accessor :owner_name
  attr_accessor :status  # received, in_repair, done, delivered
  attr_accessor :number_of_wheels
  attr_accessor :engine
  attr_accessor :fuel_type

  def initialize(make, model, year, color, owner_name, status = "received")
    @make = make
    @model = model
    @year = year
    @color = color
    @owner_name = owner_name
    @status = status
  end
end

class Motorcycle < Vehicle
  def initialize(make, model, year, color, owner_name)
    super(make, model, year, color, owner_name)
    @number_of_wheels = 2
  end
end

class FourWheelVehicle < Vehicle
  def initialize(make, model, year, color, owner_name)
    super(make, model, year, color, owner_name)
    @number_of_wheels = 4
  end
end

class Car < FourWheelVehicle
end

class SUV < FourWheelVehicle
end

class Minivan < FourWheelVehicle
end

class PickUpTruck < FourWheelVehicle
end

mini = Car.new("MINI", "Cooper", 2016, "Blue", "Abraham Kuri")

ducati = Motorcycle.new("Ducati", "848", 2018, "Red", "Carlos Medellín")
ducati.status = "in_repair"

sienna = Minivan.new("Toyota", "Sienna", 2015, "White", "Pedro Lopez")
sienna.status = "delivered"

rav4 = SUV.new("Toyota", "RAV4", 2010, "Gray", "Luis Perez")
rav4.status = "delivered"

cheyenne = PickUpTruck.new("Chevrolet", "Cheyenne", 2017, "Yellow", "Brayan Rodríguez")
cheyenne.status = "delivered"

titan = PickUpTruck.new("Nissan", "Titan", 2014, "Gray", "Rafael Cárdenas")
titan.status = "delivered"

vehicles = [mini, ducati, sienna, rav4, cheyenne, titan]
shop = VehicleRepairShop.new(vehicles)
