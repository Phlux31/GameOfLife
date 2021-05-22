require "timeout"

size = 20  # defines grid size
gen = 1
grid = [] # create base grid 
(0..size).each do |row|
    grid[row] = []
    (0..size).each do |column|
        grid[row][column] = "* "
    end
end

grid[15][4] = "0 "  # base living cells - Blinker - will alternate between two positions
grid[15][5] = "0 "
grid[15][6] = "0 "

grid[0][2] = "0 "  # base living cells - Glider - will travel across the grid
grid[1][2] = "0 "
grid[2][2] = "0 "
grid[2][1] = "0 "
grid[1][0] = "0 "

grid[3][15] = "0 "  # base living cells - Loaf - will be static throughout the program
grid[2][16] = "0 "
grid[2][17] = "0 "
grid[3][18] = "0 "
grid[4][18] = "0 "
grid[5][17] = "0 "
grid[4][16] = "0 "

puts "-----Welcome to Conway's Game of Life Simulator-----"
puts
puts "Press 'enter' to begin."
gets

looping = true

while looping
    system("cls")  # clear system screen each round so there aren't multiple grids
    puts  # line breaks for UX
    puts

    (0..size).each do |row|  # print grid
        (0..size).each do |column|
            print grid[row][column]
        end
        puts
    end
    puts "-----GENERATION #{gen}-----".center size * 2
    
    dead_cells = []  # create base integer grid that will count dead cells' neighbors - this resets to counter to 0 each loop
    (0..size).each do |row|
        dead_cells[row] = []
        (0..size).each do |column|    
            dead_cells[row][column] = 0
        end
    end

    (0..size).each do |row|  # adds values to dead_cells array based on number of neighbors                        
        (0..size).each do |column|
            if grid[row][column] == "* "
                if row < size                          
                    if grid[row + 1][column] == "0 "  # checking bottom
                        dead_cells[row][column] += 1
                    end
                end
                if row > 0
                    if grid[row - 1][column] == "0 "     # checking top
                        dead_cells[row][column] += 1
                    end
                end
                if column < size                           # checking right
                    if grid[row][column + 1] == "0 " 
                        dead_cells[row][column] += 1
                    end
                end
                if column > 0                            # checking left
                    if grid[row][column - 1] == "0 " 
                        dead_cells[row][column] += 1
                    end
                end
                if column > 0 && row > 0                 # checking top left
                    if grid[row - 1][column - 1] == "0 " 
                        dead_cells[row][column] += 1
                    end
                end
                if column < size && row < size               # checking bottom right
                    if grid[row + 1][column + 1] == "0 " 
                        dead_cells[row][column] += 1
                    end
                end
                if column < size && row > 0                # checking top right
                    if grid[row - 1][column + 1] == "0 " 
                        dead_cells[row][column] += 1
                    end
                end
                if column > 0 && row < size                # checking bottom left
                    if grid[row + 1][column - 1] == "0 " 
                        dead_cells[row][column] += 1
                    end
                end
            end
        end
    end
    
    
    
    live_cells = []  # create base integer grid that will count live cells' neighbors - this resets to counter to 0 each loop
    (0..size).each do |row|
        live_cells[row] = []
        (0..size).each do |column|
            live_cells[row][column] = 0
        end
    end

    (0..size).each do |row|  # adding values to live_cells array based on number of neighbors                        
        (0..size).each do |column|
            if grid[row][column] == "0 "
                if row < size  # checks bottom
                    if grid[row + 1][column] == "0 "    
                        live_cells[row][column] += 1
                    end
                end
                if row > 0  # checks top
                    if grid[row - 1][column] == "0 "     
                        live_cells[row][column] += 1
                    end
                end
                if column < size # checks right
                    if grid[row][column + 1] == "0 " 
                        live_cells[row][column] += 1
                    end
                end
                if column > 0  # checks left
                    if grid[row][column - 1] == "0 " 
                        live_cells[row][column] += 1
                    end
                end
                if column > 0 && row > 0  # checks top left
                    if grid[row - 1][column - 1] == "0 " 
                        live_cells[row][column] += 1
                    end
                end
                if column < size && row < size  # checks bottom right
                    if grid[row + 1][column + 1] == "0 " 
                        live_cells[row][column] += 1
                    end
                end
                if column < size && row > 0  # checks top right
                    if grid[row - 1][column + 1] == "0 " 
                        live_cells[row][column] += 1
                    end
                end
                if column > 0 && row < size  # checks bottom left
                    if grid[row + 1][column - 1] == "0 " 
                        live_cells[row][column] += 1
                    end
                end
            end
        end
    end

    (0..size).each do |row|  # apply Game of Life rules
        (0..size).each do |column|
            if live_cells[row][column] < 2 || live_cells[row][column] > 3
                grid[row][column] = "* "
            end
            if dead_cells[row][column] == 3
                grid[row][column] = "0 "
            end
        end
    end
    
    puts
    puts "Press enter to quit.".center size * 2
    begin  # this timer allows the grid to continuously update without user input
      Timeout::timeout 1 do
        gets.chomp
        looping = false
      end
    rescue Timeout::Error
    end

    gen += 1
end
puts "Thanks for using Conway's Game of Life Simulator."
