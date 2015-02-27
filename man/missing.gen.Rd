\name{missing.gen}
\alias{missing.gen}
\title{
Generating random missing values on a data matrix
}
\description{
The function generates a number of missing values (NA) completely at random on a data matrix. Totally missing rows (i.e., rows with all NA) are avoided.
}
\usage{
missing.gen(mat, nummiss)
}
\arguments{
  \item{mat}{
a matrix of numerical data.
}
  \item{nummiss}{
number of missing values.
}
}
\details{
The function generates a number of missing values (NA) completely at random on a data matrix. Totally missing rows (i.e., rows with all NA) are avoided.
}
\value{
The data matrix with missing values (NA).
}
\author{
Nadia Solaro, Alessandro Barbiero, Giancarlo Manzi, Pier Alda Ferrari
}
\seealso{
\code{\link{missing.gen0}}
}
\examples{
sigma <- matrix(0.4, 4, 4)
diag(sigma) <- 1
x0 <- rmvnorm(n=100, mean=rep(0, 4), sigma=sigma)
x0 # complete matrix
x <- missing.gen(x0, 50)
x # matrix with 50 missing values
}
\keyword{classes}
\keyword{multivariate}
\keyword{NA}

