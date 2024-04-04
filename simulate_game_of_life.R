# Title: Simulate Conway's Game of Life
# Author: Przemyslaw Marcowski, PhD
# Email: p.marcowski@gmail.com
# Date: 2024-02-03
# Copyright (c) 2024 Przemyslaw Marcowski
#
# This code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

# This script simulates variations of Conway's Game of Life cellular automaton.
# Users can customize the grid size to adjust the dimensions of the cellular
# automaton, set the number of iterations to control the simulation duration,
# and specify the initial probability of a cell being alive at the start.
# Additionally, the script allows users to select from different birth and
# survival rules to experiment with various automaton behaviors. The grid
# evolution is visualized in real-time, enabling users to observe the emerging
# patterns as the simulation progresses.
#
# Supported rule variations:
#   "B3/S23" (Conway's original rules, 1970):
#     - A dead cell is born if it has exactly 3 live neighbors
#     - A live cell survives if it has 2 or 3 live neighbors
#     - A live cell dies (due to underpopulation or overcrowding) otherwise
#
#   "B2/S":
#     - A dead cell is born if it has exactly 2 live neighbors
#     - A live cell survives if it has any live neighbors (1 to 8)
#     - A live cell dies if it has no live neighbors (isolation)
#
#   "B36/S23":
#     - A dead cell is born if it has 3 or 6 live neighbors
#     - A live cell survives if it has 2 or 3 live neighbors
#     - A live cell dies (due to underpopulation or overcrowding) otherwise

game_of_life <- function(size = 20, tlength = 50, prob = 0.5, rule = "B3/S23") {
  # Simulates and animates Conway's Game of Life.
  # Starts with a random grid based on specified probability.
  # Grid evolves over iterations based on cell state and neighbors.
  # Visualizes grid evolution in real-time.
  # Allows customization of birth/survival rules (B3/S23, B2/S, B36/S23).
  #
  # Args:
  #   size: Edge length of square grid (total cells: size^2). Default is 20.
  #   tlength: Number of iterations to run. Default is 50.
  #   prob: Initial probability of a cell being alive. Default: 0.5.
  #   rule: Birth/survival rules. One of: "B3/S23", "B2/S", "B36/S23". 
  #         Default is "B3/S23".
  #
  # Returns:
  #   No return object. Renders animated plot showing grid evolution.
  #   Each animation frame corresponds to one iteration.

  # Validate size input
  if (!is.numeric(size) || size <= 0) {
    stop("Invalid size. Must be a positive integer.")
  }
  
  # Validate tlength input
  if (!is.numeric(tlength) || tlength <= 0) { 
    stop("Invalid tlength. Must be a positive integer.")
  }
  
  # Validate rule input
  valid_rules <- c("B3/S23", "B2/S", "B36/S23")
  if (!rule %in% valid_rules) {
    stop("Invalid rule. Must be one of: ", paste(valid_rules, collapse = ", "), ".")
  }
  
  # Validate prob input
  if (!is.numeric(prob) || prob < 0 || prob > 1) {
    stop("Invalid prob. Must be a numeric value between 0 and 1.")
  }

  # Extract birth and survival rules
  rule_parts <- strsplit(rule, "/")[[1]]
  birth_rule <- as.integer(regmatches(rule_parts[1], gregexpr("[0-9]", rule_parts[1]))[[1]])
  survival_rule <- as.integer(regmatches(rule_parts[2], gregexpr("[0-9]", rule_parts[2]))[[1]])

  # Initialize grid with random states
  grid <- matrix(rbinom(size^2, 1, prob), nrow = size)

  # Set up plotting environment
  par(mfrow = c(1, 1), pty = "s")

  # Main simulation loop
  for (t in 1:tlength) {
    # Create copy of grid to hold next state
    new_grid <- grid

    # Apply Game of Life rules to each cell
    for (i in 1:size) {
      for (j in 1:size) {
        # Calculate number of live neighbors
        neighbors <- sum(grid[pmax(1, i - 1):pmin(size, i + 1), pmax(1, j - 1):pmin(size, j + 1)]) - grid[i, j]

        # Survival check: cell survives if survival rule is empty or neighbors are in survival rule 
        if (grid[i, j] == 1) {
          if (length(survival_rule) == 0 || neighbors %in% survival_rule) {
            new_grid[i, j] <- 1 # cell survives
          } else {
            new_grid[i, j] <- 0 # cell dies
          }
        
        # Birth check: cell is born if it's dead and neighbors are in birth rule  
        } else if (grid[i, j] == 0) {
          if (neighbors %in% birth_rule) {
            new_grid[i, j] <- 1 # cell is born
          } else {
            new_grid[i, j] <- 0 # remains dead
          }
        }
      }
    }

    # Update grid for next iteration
    grid <- new_grid

    # Visualize new grid
    image(grid, col = c("white", "black"), axes = FALSE)
    box()

    # Add title and iteration number
    title(paste("Simulation of the Game of Life:", rule))
    mtext(paste("Time:", t, "/", tlength), side = 1, line = 0.25)

    # Add legend for cell types
    legend(
      x = "bottom",
      inset = c(0.5, -0.175),
      legend = c("Dead", "Alive"),
      fill = c("white", "black"),
      horiz = TRUE,
      xpd = TRUE,
      title = "Cell state"
    )

    Sys.sleep(0.1) # pause for animation effect

    # Message simulation complete
    if (t == tlength) {
      message("Simulation complete after specified time: ", tlength)
    }
  }
}

# Run simulation with specified parameters
game_of_life(size = 50, tlength = 100, prob = 0.2, rule = "B36/S23")