require File.join(Dir.pwd, 'bin/require_tree')

matching_service = FareMatchingService.new
capping_service = FareCappingService.new

daily_input = [
  ['Monday', '10:20', 2, 1],
  ['Monday', '10:45', 1, 1],
  ['Monday', '16:15', 1, 1],
  ['Monday', '18:15', 1, 1],
  ['Monday', '19:00', 1, 2],
  ['Tuesday', '10:20', 1, 2],
  ['Tuesday', '10:45', 1, 1],
  ['Tuesday', '16:15', 1, 1],
  ['Tuesday', '18:15', 1, 1],
  ['Tuesday', '19:00', 1, 2],
]

weekly_input = [
  ['Monday', '10:20', 1, 2],
  ['Monday', '10:45', 1, 1],
  ['Monday', '16:15', 1, 1],
  ['Monday', '18:15', 1, 1],
  ['Monday', '19:00', 1, 2],
  ['Tuesday', '10:20', 1, 2],
  ['Tuesday', '10:45', 1, 1],
  ['Tuesday', '16:15', 1, 1],
  ['Tuesday', '18:15', 1, 1],
  ['Tuesday', '19:00', 1, 2],
  ['Wednesday', '10:20', 1, 2],
  ['Wednesday', '10:45', 1, 1],
  ['Wednesday', '16:15', 1, 1],
  ['Wednesday', '18:15', 1, 1],
  ['Wednesday', '19:00', 1, 2],
  ['Thursday', '10:20', 1, 2],
  ['Thursday', '10:45', 1, 1],
  ['Thursday', '16:15', 1, 1],
  ['Thursday', '18:15', 1, 1],
  ['Thursday', '19:00', 1, 2],
  ['Friday', '10:45', 1, 1],
  ['Friday', '16:15', 1, 1],
  ['Friday', '18:15', 1, 1],
  ['Saturday', '10:20', 1, 1],
  ['Saturday', '10:45', 1, 1],
]

input = weekly_input

input.each do |inp|
  cost = matching_service.find_cost(day: inp[0], time: inp[1], from: inp[2], to: inp[3])

  capped_cost = capping_service.capped_cost(day: inp[0], from: inp[2], to: inp[3], cost: cost)
end
