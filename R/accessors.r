# Accessors Methods
# =================

#' @export get_X
setGeneric(
  'get_X',
  function(pseqMLR) standardGeneric('get_X'))
setMethod(
  'get_X',
  signature('pseqML'),
  function(pseqMLR) {
    x <- phyloseq::otu_table(pseqMLR@data)
    x <- as.data.frame(t(x))
    return(x)
  })


#' @export get_Y
setGeneric(
  'get_Y',
  function(pseqMLR) standardGeneric('get_Y'))
setMethod(
  'get_Y',
  signature('pseqML'),
  function(pseqMLR) {
    y <- as.factor(phyloseq::get_variable(pseqMLR@data, pseqMLR@target))
    return(y)
  })


#' @export get_XY
setGeneric(
  'get_XY',
  function(pseqMLR) standardGeneric('get_XY'))
setMethod(
  'get_XY',
  signature('pseqML'),
  function(pseqMLR) {
    x <- get_X(pseqMLR)
    y <- get_Y(pseqMLR)
    xy <- cbind.data.frame(
      x,
      target = y
    )
    return(xy)
  })
