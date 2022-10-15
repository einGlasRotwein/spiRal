
spiral <- function(last_num) {
  
  # Determine matrix size
  # Empty spaces will later be filled with NAs
  m_size <- ceiling(sqrt(last_num))
  
  x <- matrix(nrow = m_size, ncol = m_size)
  center_idx <- find_center(x)
  
  x <- fill_top(x, center_idx)
  x <- fill_bottom(x, center_idx)
  x <- fill_right(x, center_idx)
  x <- fill_left(x, center_idx)
  
  # Trim numbers that are too large
  x[x > last_num] <- NA
  
  # Delete rows/columns that consist entirely of NAs
  x <- x[rowSums(is.na(x)) != ncol(x), colSums(is.na(x)) != nrow(x)]
  
  return(x)
}

# Determine the size of the matrix
set_m_size <- function(last_num) {
  ceiling(sqrt(15))
}

# Find matrix center
# x = empty matrix
find_center <- function(x) {
  # If we know nrows, we know ncols, because we only use symmetric matrices
  center_idx <- floor(median(1:nrow(x)))
  return(center_idx)
}

# Fill the top "pyramid" of the spiral
fill_top <- function(x, center_idx) {
  temp_row <- center_idx
  temp_vec <- c(center_idx, center_idx + 1)
  add_vec <- c(1, 2)
  to_add <- 7
  
  repeat{
    # Cut last elements if matrix is shorter if necessary
    if (length(temp_vec) > ncol(x)) {
      temp_vec <- temp_vec[1:ncol(x)] 
    }
    
    if (length(add_vec) > ncol(x)) {
      add_vec <- add_vec[1:ncol(x)] 
    }
    
    x[temp_row, temp_vec] <- add_vec
    
    # Move one row up
    temp_row <- temp_row - 1
    
    # Add one element to each side
    temp_vec <- c(temp_vec[1] - 1, temp_vec, temp_vec[length(temp_vec)] + 1)
    
    # Update add_vec
    add_vec <- add_vec + to_add
    add_vec <- c(add_vec[1] - 1, add_vec, add_vec[length(add_vec)] + 1)
    
    to_add <- to_add + 8
    
    if(temp_row == 0){
      break
    }
  }
  
  return(x)
}

# Fill the bottom "pyramid" of the spiral
fill_bottom <- function(x, center_idx) {
  temp_row <- center_idx + 1
  temp_vec <- (center_idx-1):(center_idx + 1)
  add_vec <- 5:3
  to_add <- 11
  
  repeat{
    # Cut last elements if matrix is shorter if necessary
    if (length(temp_vec) > ncol(x)) {
      temp_vec <- temp_vec[(length(temp_vec) - ncol(x) + 1):(ncol(x) + 1)] 
    }
    
    if (length(add_vec) > ncol(x)) {
      add_vec <- add_vec[(length(add_vec) - ncol(x) + 1):(ncol(x) + 1)] 
    }
    
    x[temp_row, temp_vec] <- add_vec
    
    # Move one row down
    temp_row <- temp_row + 1
    
    # Add one element to each side
    temp_vec <- c(temp_vec[1] - 1, temp_vec, temp_vec[length(temp_vec)] + 1)
    
    # Update add_vec
    add_vec <- add_vec + to_add
    add_vec <- c(add_vec[1] + 1, add_vec, add_vec[length(add_vec)] - 1)
    
    to_add <- to_add + 8
    
    if(temp_row == (nrow(x) + 1)){
      break
    }
  }
  
  return(x)
}

# Fill the right "pyramid" of the spiral
fill_right <- function(x, center_idx) {
  temp_col <- center_idx + 1
  temp_vec <- c(center_idx, center_idx + 1)
  add_vec <- c(2, 3)
  to_add <- 9
  
  repeat{
    # Cut last elements if matrix is shorter if necessary
    if (length(temp_vec) > nrow(x)) {
      temp_vec <- temp_vec[1:nrow(x)]
    }
    
    if (length(add_vec) > nrow(x)) {
      add_vec <- add_vec[1:nrow(x)] 
    }
    
    x[temp_vec, temp_col] <- add_vec
    
    # Move one col right
    temp_col <- temp_col + 1
    
    # Add one element to each side
    temp_vec <- c(temp_vec[1] - 1, temp_vec, temp_vec[length(temp_vec)] + 1)
    
    # Update add_vec
    add_vec <- add_vec + to_add
    add_vec <- c(add_vec[1] - 1, add_vec, add_vec[length(add_vec)] + 1)
    
    to_add <- to_add + 8
    
    if(temp_col == (ncol(x) + 1)){
      break
    }
  }
  
  return(x)
}

# Fill the left "pyramid" of the spiral
fill_left <- function(x, center_idx) {
  temp_col <- center_idx - 1
  temp_vec <- c((center_idx - 1):(center_idx + 1))
  add_vec <- 7:5
  to_add <- 13
  
  repeat{
    # Cut last elements if matrix is shorter if necessary
    if (length(temp_vec) > nrow(x)) {
      temp_vec <- temp_vec[(length(temp_vec) - nrow(x) + 1):(nrow(x) + 1)] 
    }
    
    if (length(add_vec) > nrow(x)) {
      add_vec <- add_vec[(length(add_vec) - nrow(x) + 1):(nrow(x) + 1)] 
    }
    
    x[temp_vec, temp_col] <- add_vec
    
    # Move one col right
    temp_col <- temp_col - 1
    
    # Add one element to each side
    temp_vec <- c(temp_vec[1] - 1, temp_vec, temp_vec[length(temp_vec)] + 1)
    
    # Update add_vec
    add_vec <- add_vec + to_add
    add_vec <- c(add_vec[1] + 1, add_vec, add_vec[length(add_vec)] - 1)
    
    to_add <- to_add + 8
    
    if(temp_col == 0){
      break
    }
  }
  
  return(x)
}
