\name{ercomp}
\alias{ercomp}
\alias{ercomp.formula}
\alias{ercomp.plm}
\title{Estimation of the error components}
\description{
  This function enables the estimation of the components of the errors
  of a panel model.
}
\usage{
ercomp(object, ...)
\method{ercomp}{formula}(object, data, effect = c("individual", "time", "twoways"), 
                         method = c("swar", "walhus", "amemiya", "nerlove"),
                         index = NULL, ...)
\method{ercomp}{plm}(object, ...)

}
\arguments{
  \item{object}{a \code{formula} or a \code{plm} object,}
  \item{data}{a \code{data.frame},}
  \item{method}{method of estimation for the variance components,
    see \code{\link{lm}} for details,}
  \item{effect}{the effects introduced in the model, see
    \code{\link{lm}} for details,}
  \item{index}{the indexes,} 
  \item{\dots}{further arguments.}
}
\value{
  
  an object of class \code{"ercomp"}: a list containing a list called
  \code{sigma2} which contains the estimation of the components of the
  variance of the errors, and \code{theta} which is the parameters used
  for the transformation of the variables.
  
}
\details{

}
\references{

    Amemiyia, T. (1971) The estimation of the variances in a
  variance--components model, \emph{International Economic Review}, \bold{12},
  pp.1--13.

  Nerlove, M. (1971) Further evidence on the estimation of dynamic
  economic relations from a time--series of cross--sections,
  \emph{Econometrica}, \bold{39}, pp.359--382.

  Swamy, P.A.V.B. and  Arora, S.S. (1972) The exact finite sample
  properties of the estimators of coefficients in the error components
  regression models, \emph{Econometrica}, \bold{40}, pp.261--275.

  Wallace, T.D. and  Hussain, A. (1969) The use of error components
  models in combining cross section with time series data,
  \emph{Econometrica}, \bold{37}(1), pp.55--72.

}
\seealso{
  \code{\link{plm}} where the estimation of the components of the
  variance of the errors are used 
}
\examples{

}
\author{Yves Croissant}
\keyword{}