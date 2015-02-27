\name{ForImp.Mahala}
\alias{ForImp.Mahala}
\title{
Imputation of missing data by using Nearest Neighbour Imputation with the Mahalanobis distance
}
\description{
This function imputes quantitative missing data by using Nearest Neighbour Imputation (NNI) with the Mahalanobis distance in a forward and sequential step-by-step process that starts from the complete part of data.
}
\usage{
ForImp.Mahala(mat, probs=seq(0, 1, 0.1), q="10\%", add.unit=TRUE, squared=FALSE, 
tol=1e-6)
}
\arguments{
\item{mat}{
a quantitative data matrix with missing entries.
}
\item{probs}{
vector of probabilities with values in \eqn{[0, 1]} for computing quantiles of Mahalanobis distances in selection of donors. Default option: \code{probs=seq(0,1,0.1)} calculates the deciles of distances. Quantiles are computed with the generic function \code{quantile}. 
}
\item{q}{
string of the form \code{"X\%"}, with \code{X}=integer. It gives the quantile of Mahalanobis distances corresponding to the first \code{"X\%"} distances as computed (and named) by the function \code{quantile} with probabilities specified in the argument \code{probs}.
}
\item{add.unit}{
a logical value. If \code{add.unit=TRUE} (default), the covariance matrix in the Mahalanobis distance is computed at every step of the procedure by including also the incomplete unit whose donors are to be selected. Otherwise, \code{add.unit=FALSE} indicates that computation involves the complete units only.
}
\item{squared}{
a logical value indicating if the Mahalanobis distance has to be used (\code{squared=} \code{FALSE}, default) or the squared Mahalanobis distance (\code{squared=TRUE}).
}
\item{tol}{
tolerance factor introduced to prevent numerical problems occuring when distances of complete units are equal to the choosen quantile \code{q}. Default is \code{tol=1e-6}.
}
}
\details{
\code{ForImp.Mahala} is a forward imputation method alternative to the \code{ForImp.PCA} procedure for imputing quantitative missing data (see \code{\link{ForImp.PCA}}). It does not embrace Stage 1 since it works directly on the original variables. Regarding Stage 2, the basic metric for the NNI method is the Mahalanobis distance. Steps 2 to 3 are therefore iteratively repeated until the starting data matrix is completely imputed.

Unlike \code{ForImp.PCA}, the \code{ForImp.Mahala} procedure requires that the number \eqn{n} of units is equal or greater than the number \eqn{p} of variables at every step of the procedure, otherwise the covariance matrix involved in the Mahalanobis distance is not invertible. 
For further details, see the references below.
}
\value{
The imputed data matrix.
}
\references{
Solaro, N., Barbiero, A., Manzi. G., Ferrari, P.A. (2014). Algorithmic-type imputation techniques with different data structures: Alternative approaches in comparison. In: Vicari, D., Okada, A., Ragozini, G., Weihs, C. (eds), \emph{Analysis and modeling of complex data in behavioural and social sciences}, Studies in Classification, Data Analysis, and Knowledge Organization. Springer International Publishing, Cham (CH): 253-261

Solaro, N., Barbiero, A., Manzi, G., Ferrari, P.A. (2015) A sequential distance-based approach for imputing missing data: The Forward Imputation. Under review 
}
\author{
Nadia Solaro, Alessandro Barbiero, Giancarlo Manzi, Pier Alda Ferrari
}
\seealso{
\code{\link{ForImp.PCA}}
}
\examples{
# EXAMPLE with multivariate normal data (MVN)
# require('mvtnorm')
# number of variables
p <- 5
# correlation matrix
rho <- 0.8
Rho <- matrix(rho, p, p)
diag(Rho) <- 1
Rho
# mean vector
vmean <- rep(0,p)
vmean
# number of units
n <- 1000
# percentage of missing values
percmiss <- 0.2
nummiss <- n*p*percmiss
nummiss
# generation of a complete matrix
set.seed(1)
x0 <- rmvnorm(n, mean=vmean, sigma=Rho)
x0
# generating a matrix with missing data
x <- missing.gen(x0, nummiss) 
# imputing missing values
xForImpMahala <- ForImp.Mahala(x)
xForImpMahala
# computing the Relative Mean Square Error
error <- sum(apply((x0-xForImpMahala)^2/diag(var(x0)),2,sum)) / n
error


# EXAMPLE with real data
data(airquality)
m0 <- airquality
m0
# selecting the first 4 columns, with quantitative data
m <- m0[, 1:4]
m
# imputation
mi <- ForImp.Mahala(m)
mi
# plot of imputed values for variable "Ozone"
ozone.miss.ind <- which(is.na(m)[,1])
plot(mi[ozone.miss.ind,1], axes=FALSE, pch=19, ylab="imputed values of Ozone", 
  xlab="observation index")
axis(2)
axis(1, at=1:length(ozone.miss.ind), labels=ozone.miss.ind, las=2)
box()
abline(v=1:length(ozone.miss.ind), lty=3, col="grey")
}
\keyword{multivariate}
\keyword{NA}
\keyword{nonparametric}