\name{GenForImp-package}
\alias{GenForImp-package}
\docType{package}
\title{
The Forward Imputation: A Sequential Distance-Based Approach for Imputing Missing Data
}
\description{Two methods based on the Forward Imputation (\emph{ForImp}) approach are implemented for the imputation of quantitative missing data. One method alternates the Nearest Neighbour Imputation (NNI) method and Principal Component Analysis (function \code{\link{ForImp.PCA}}), the other uses NNI with the Mahalanobis distance (function \code{\link{ForImp.Mahala}}). 
\emph{ForImp} is a sequential distance-based approach that performs imputation of missing data in a forward, step-by-step process involving subsets of units according to their ``completeness rate''. During the iterative process, the complete part of data is updated thus becoming larger and larger. No initialization of missing entries is required.
\emph{ForImp} is inherent in the nonparametric and exploratory-descriptive framework since it does not require a priori distribution assumptions on data.
Two supplementary functions (\code{\link{missing.gen}} and \code{\link{missing.gen0}}) are also provided to generate Missing Completely At Random (MCAR) values on a data matrix.
}
\details{
\tabular{ll}{
Package: \tab GenForImp\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2015-02-27\cr
License: \tab GPL-3\cr
}
}
\author{Nadia Solaro, Alessandro Barbiero, Giancarlo Manzi, Pier Alda Ferrari

Maintainer: Alessandro Barbiero <alessandro.barbiero@unimi.it>
}
\references{
Solaro, N., Barbiero, A., Manzi. G., Ferrari, P.A. (2014). Algorithmic-type imputation techniques with different data structures: Alternative approaches in comparison. In: Vicari, D., Okada, A., Ragozini, G., Weihs, C. (eds),
\emph{Analysis and modeling of complex data in behavioural and social sciences}, Studies in Classification, Data Analysis, and Knowledge Organization. Springer International Publishing, Cham (CH): 253-261
\url{http://link.springer.com/chapter/10.1007/978-3-319-06692-9_27}

Solaro, N., Barbiero, A., Manzi, G., Ferrari, P.A. (2015) A sequential distance-based approach for imputing missing data: The Forward Imputation. Under review 
}
\keyword{classes}
\keyword{multivariate}
\keyword{NA}
\keyword{nonparametric}
\keyword{package}
