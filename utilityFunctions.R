# Computes highest density interval from a sample of
# representative values, estimated as shortest credible interval.
# Arguments: posterior is a vector of representative values from a
# probability distribution.  credMass is a scalar between 0 and 1,
# indicating the mass within the credible interval that is to be
# estimated.  Value: HDIlim is a vector containing the limits of
# the HDI. Altered slightly from Richard McElreath's rethinking 
# package source code

HDI <- function(posterior, credMass = 0.95) {
  sortedPts <- sort(posterior)
  ciIdxInc <- ceiling(credMass * length(sortedPts))
  nCIs <- length(sortedPts) - ciIdxInc
  ciWidth <- rep(0, nCIs)
  for (i in 1:nCIs) {
    ciWidth[i] <- sortedPts[i + ciIdxInc] - sortedPts[i]
  }
  HDImin <- sortedPts[which.min(ciWidth)]
  HDImax <- sortedPts[which.min(ciWidth) + ciIdxInc]
  HDIlim <- c(HDImin, HDImax)
  return(HDIlim)
}

# plots credible intervals. Takes a vector of parameter estimates. Interval specifies the desired probability mass. If probs isn't NULL, specifies the desired quantile or quantile interval. Lower.tail=TRUE specifies which tail is of interest if a single quantile is selected. Adjust alters the density smoothing.

plotInterval <- function(samples, interval = 0.5, probs = NULL, lower.tail = TRUE, HDI = TRUE, adjust = 2, xlims = c(0, 1), yOffset=0.1,
  col = "black", ...) {
  sDens <- as.data.frame(density(samples, from = xlims[1], 
    to = xlims[2], adjust = adjust)[1:2])
  if (is.null(probs) == FALSE) {
    quant <- quantile(samples, probs = probs)
    if (length(probs) == 1) {
      if (lower.tail == TRUE) {
        densUI <- sDens[sDens$x <= quant, ]
      } else {
        densUI <- sDens[sDens$x >= quant, ]
      }
    }
    if (length(probs) > 1) {
      densUI <- sDens[sDens$x >= quant[1] & sDens$x <= quant[2],]
    }
    plot(sDens, xlim = xlims, xaxs = "i", yaxs = "i", 
      ylim = c(0, max(sDens$y) + yOffset), xlab = "parameter", 
      ylab = "", las = 1, type = "l", main="")
    polygon(x = c(densUI$x, rev(densUI$x)), y = c(rep(0, 
      dim(densUI)[1]), rev(densUI$y)), col = col)
  }
  if (HDI == TRUE) {
      quant <- HDI(samples, credMass = interval)
      densUI <- sDens[sDens$x >= quant[1] & sDens$x <= quant[2],]
      plot(sDens, xlim = xlims, xaxs = "i", yaxs = "i", ylim = 
        c(0, max(sDens$y) + yOffset), xlab = "parameter", ylab = "", 
        las = 1, type = "l", main="")
      polygon(x = c(densUI$x, rev(densUI$x)), y = c(rep(0, 
        dim(densUI)[1]), rev(densUI$y)), col = col)
  }
}
