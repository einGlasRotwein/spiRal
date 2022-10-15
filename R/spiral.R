
#' Creates a spiral
#'
#' @param last_num Integer. What the last number of the spiral should be.
#'
#' @details 
#' 
#' Returns a matrix where numbers are arranged in a spiral. The center of the 
#' matrix is 1, and numbers increase clockwise towards the outside of the 
#' matrix.
#' 
#' If the numbers can't fill out the matrix entirely (e.g., the numbers from 
#' 1 - 13 can't be used to create a 3 x 3 or 4 x 4 matrix), empty spots are 
#' filled with NAs.
#'
#' @examples 
#' 
#' spiral(9)
#' spiral(13)
#' spiral(42)
#'
#' @author Juli Nagel \email{juliane.nagel@zi-mannheim.de}
#' @export
#'
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

#' Finds center of a matrix
#'
#' @param x A matrix. Rows and columns must be the same number.
#'
find_center <- function(x) {
  # If we know nrows, we know ncols, because we only use symmetric matrices
  center_idx <- floor(median(1:nrow(x)))
  return(center_idx)
}

#' Fills the "top" pyramid
#'
#' @param x A matrix. Rows and columns must be the same number.
#' @param center_idx The location of the center of the matrix, previously 
#'                   determined with \code{find_center()}.
#'
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

#' Fills the "bottom" pyramid
#'
#' @param x A matrix. Rows and columns must be the same number.
#' @param center_idx The location of the center of the matrix, previously 
#'                   determined with \code{find_center()}.
#'
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

#' Fills the "right" pyramid
#'
#' @param x A matrix. Rows and columns must be the same number.
#' @param center_idx The location of the center of the matrix, previously 
#'                   determined with \code{find_center()}.
#'
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

#' Fills the "left" pyramid
#'
#' @param x A matrix. Rows and columns must be the same number.
#' @param center_idx The location of the center of the matrix, previously 
#'                   determined with \code{find_center()}.
#'
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
