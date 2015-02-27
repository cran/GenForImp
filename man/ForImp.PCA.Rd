\name{ForImp.PCA}
\alias{ForImp.PCA}
\title{
Imputation of missing data by alternating Nearest Neighbour Imputation and Principal Component Analysis
}
\description{
This function imputes quantitative missing data by alternating Nearest Neighbour Imputation (NNI) method and Principal Component Analysis (PCA) in a forward and sequential step-by-step process that starts from the complete part of data.
}
\usage{
ForImp.PCA(mat, stand=FALSE, cor=FALSE, r=2, probs=seq(0, 1, 0.1), q="10\%", 
tol=1e-6)
}
\arguments{
  \item{mat}{
a quantitative data matrix with missing entries.
}
  \item{stand}{
a logical value indicating if variables should be standardized (\code{stand=TRUE}), or not (\code{stand=FALSE}, default) before the imputation process starts.
}
  \item{cor}{
a logical value. If \code{cor=TRUE}, PCA is run on the correlation matrix; if \code{cor=FALSE} the covariance matrix is used (default).
}
  \item{r}{
a positive value (equal or greater than 1) indicating
the order of the weighted Minkowski distance to be computed for selecting donors. In particular, \code{r=1} is Manhattan (or city-block) distance, and \code{r=2} is Euclidean distance (default). \code{r=Inf} denotes Lagrange (or Chebyshev or sup) distance. 
}
  \item{probs}{
vector of probabilities with values in \eqn{[0, 1]} for computing quantiles of Minkowski distances in selection of donors. Default option: \code{probs=seq(0,1,0.1)} calculates the deciles of distances. Quantiles are computed with the generic function \code{quantile}. 
}
  \item{q}{
string of the form \code{"X\%"}, with \code{X}=integer. It gives the quantile of Minkowski distances corresponding to the first \code{"X\%"} distances as computed (and named) by the function \code{quantile} with probabilities specified in the argument \code{probs}.
}
\item{tol}{
tolerance factor introduced to prevent numerical problems occuring when distances of complete units are equal to the choosen quantile \code{q}. Default is \code{tol=1e-6}.
}
}
\details{
The \code{ForImp.PCA} procedure exploits the PCA method for setting-up so-called ``Pseudo-Principal Components'' (PPCs). These are artificial, missing-data free variables computed for all the units (i.e. both complete and incomplete) by using common observed variables without missing values. PPCs synthesize the main relevant information in the complete part of data and transfer them to incomplete units in a way functional to the subsequent application of the NNI method. NNI is then applied to PPCs (with a weighted Minkowski distance of order \eqn{r, r \ge 1}) in order to select donors for incomplete units. All is performed in four stages:
Stage 0: data preparation;
Stage 1: running PCA and computing PPC scores;
Stage 2: application of the NNI method;
Stage 3: imputation.
Steps 1 to 3 are iteratively repeated until the starting data matrix is completely imputed. 

\code{ForImp.PCA} does not require a number \eqn{n} of units greater than the number \eqn{p} of variables at every step of the procedure. It can work even in the presence of a starting data matrix with \eqn{n < p}. This further variant is indicated as \emph{ForImp with PCO}, i.e. Forward Imputation with the Principal Coordinates Analysis.
For further details, see the references below.
}
\value{
The imputed data matrix.
}
\references{
Gower, J.C. (2005). Principal coordinates analysis. In: Armitage, P., Colton, T. (eds), Encyclopedia of biostatistics. John Wiley & Sons, Ltd., New York 

Solaro, N., Barbiero, A., Manzi. G., Ferrari, P.A. (2014). Algorithmic-type imputation techniques with different data structures: Alternative approaches in comparison. In: Vicari, D., Okada, A., Ragozini, G., Weihs, C. (eds),
\emph{Analysis and modeling of complex data in behavioural and social sciences}, Studies in Classification, Data Analysis, and Knowledge Organization. Springer International Publishing, Cham (CH): 253-261

Solaro, N., Barbiero, A., Manzi, G., Ferrari, P.A. (2015). A sequential distance-based approach for imputing missing data: The Forward Imputation. Under review 
}
\author{
Nadia Solaro, Alessandro Barbiero, Giancarlo Manzi, Pier Alda Ferrari
}
\seealso{
\code{\link{ForImp.Mahala}}
}
\examples{
# EXAMPLE with multivariate skew-normal data (MSN)
# require('sn')
# number of variables
p <- 5
# association matrix
omega <- 0.8
Omega <- matrix(omega, p, p)
diag(Omega) <- 1
Omega
# skewness parameter
alpha <- 4
alpha <- rep(alpha,p)
alpha
# number of units
n <- 500
# percentage of missing values
percmiss <- 0.2
nummiss <- n*p*percmiss
nummiss
## computation of output parameters
## covariance matrix and univariate means and skewnesses
param <- list(xi=rep(0,p), Omega=Omega, alpha=alpha, nu=Inf)
cp <- dp2cp(param, "SN")
cp
# correlation matrix 
rho <- cov2cor(cp$var.cov)
rho
# generation of a complete matrix
set.seed(1)
x0 <- rmsn(n, Omega=Omega, alpha=alpha)
x0
# generating a matrix with missing data
x <- missing.gen(x0, nummiss) 
# imputing missing values
xForImpPCA <- ForImp.PCA(x)
xForImpPCA
# computing the Relative Mean Square Error
error <- sum(apply((x0-xForImpPCA)^2/diag(var(x0)),2,sum)) / n
error

# EXAMPLE with real data
data(airquality)
m0 <- airquality
m0
# selecting the first 4 columns, with quantitative data
m <- m0[, 1:4]
m
# imputation
mi <- ForImp.PCA(m)
mi
# plot of imputed values for variable "Ozone"
ozone.miss.ind <- which(is.na(m)[,1])
plot(mi[ozone.miss.ind,1], axes=FALSE, pch=19, ylab="imputed values of Ozone", 
  xlab="observation index")
axis(2)
axis(1, at=1:length(ozone.miss.ind), labels=ozone.miss.ind, las=2)
box()
abline(v=1:length(ozone.miss.ind), lty=3, col="grey")

# EXAMPLE with n < p: ForImp with PCO
# require('mvtnorm')
p <- 20
n <- 10
sigma <- matrix(0.4, p, p)
diag(sigma) <- 1
# complete matrix
set.seed(2)
xtrue <- rmvnorm(n=n, mean=rep(0, p), sigma=sigma)
rownames(xtrue) <- 1:n
colnames(xtrue) <- paste("V", 1:p, sep="")
xtrue 
# matrix with 10 missing values
xmiss <- missing.gen(xtrue, 10)
xmiss 
# number of missing values per unit
apply(is.na(xmiss),1,sum) 
# imputed matrix
ximp <- ForImp.PCA(xmiss)
ximp
# computing the Relative Mean Square Error
error <- sum(apply((xtrue-ximp)^2/diag(var(xtrue)),2,sum)) / n
error
}
\keyword{multivariate}
\keyword{NA}
\keyword{nonparametric}
