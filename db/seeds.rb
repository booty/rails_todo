# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

vacation_list = List.create!(
  name: "Get ready for vacation",
  sort_order: 1,
  active: true,
)
world_domination_list = List.create!(
  name: "Take over the world",
  sort_order: 2,
  active: true,
)
romance_list = List.create!(
  name: "Prepare a romantic evening",
  sort_order: 3,
  active: false,
)

todo_items = [
  [vacation_list, "Pack suitcase", false, nil],
  [vacation_list, "Buy beer", true, 1.hour.ago],
  [vacation_list, "Buy sunscreen", 1.day.ago],
  [vacation_list, "Quit job", 2.days.ago],
  [vacation_list, "Chill beer", nil],
  [world_domination_list, "Raise army", nil],
  [world_domination_list, "Get cool uniforms for army", nil],
  [world_domination_list, "Invade Canada", nil],
  [world_domination_list, "Give speech", nil],
  [world_domination_list, "Build HQ", nil],
  [world_domination_list, "Chill beer", 1.day.ago],
]

todo_items.each do |item|
  Todo.create!(
    list: item[0],
    name: item[1],
    completed_at: item[2],
  )
end
