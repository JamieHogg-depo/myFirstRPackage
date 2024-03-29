#' getBYM2scale
#'
#' @param adj_mat  fully connected binary weight matrix
#'
#' @return double scaling factor for BYM2 model
#' @import Matrix
#' @importFrom methods as
#' @export
#'
#' @examples
#' W <- matrix(c(0,1,0,1,0,1,0,1,0), byrow = TRUE, ncol = 3)
#' getBYM2scale(W)
getBYM2scale <- function(adj_mat){

  # check diagonals
  if(!all(diag(adj_mat) == 0)) stop("Diagonals must be zero...")

  # check values are binary
  if(!all(unique(as.vector(adj_mat)) %in% c(0,1))) stop("All values must be zero or one...")

  # check if symmetric
  if(!isSymmetric(adj_mat)) stop("Matrix is not symmetric...")

  # check for fully connected
  if(igraph::components(igraph::graph.adjacency(adj_mat))$no != 1) stop("Graph not fully connected...")

  # get necessary arguments for function
  adj_mat <- as(adj_mat, "sparseMatrix")
  M <- nrow(adj_mat)

  # ICAR precision matrix
  Q <- Matrix::Diagonal(M, Matrix::rowSums(adj_mat)) - adj_mat
  # Add a small jitter for numerical stability
  Q_pert <- Q + Matrix::Diagonal(M) * max(Matrix::diag(Q)) * sqrt(.Machine$double.eps)

  # Compute the diagonal elements of the covariance matrix subject to the
  # constraint that the entries of the ICAR sum to zero
  .Q_inv <- function(Q){
    Sigma <- Matrix::solve(Q)
    A <- matrix(1,1, NROW(Sigma))
    W <- Sigma %*% t(A)
    Sigma <- Sigma - W %*% solve(A %*% W) %*% Matrix::t(W)
    return(Sigma)
  }

  # get Q_inv
  Q_inv <- .Q_inv(Q_pert)

  # Compute the geometric mean of the variances (diagonal of Q_inv)
  exp(mean(log(Matrix::diag(Q_inv))))

}
