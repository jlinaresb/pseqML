# Accessors Methods
# =================

#' @export get_X1
setGeneric('get_X1', function(x) standardGeneric('get_X1'))
setMethod('get_X1', 'pseqML', function(x) as.data.frame(t(x@data@otu_table@.Data)))

#' @export get_Y1
setGeneric('get_Y1', function(x) standardGeneric('get_Y1'))
setMethod('get_Y1', 'pseqML', function(x) as.factor(phyloseq::get_variable(x@data, x@target)))


#' @export get_X
setGeneric('get_X', function(x) standardGeneric('get_X'))
setMethod('get_X', 'pseqMLR', function(x) as.data.frame(t(x@pseq@data@otu_table@.Data)))

#' @export get_Y
setGeneric('get_Y', function(x) standardGeneric('get_Y'))
setMethod('get_Y', 'pseqMLR', function(x) as.factor(phyloseq::get_variable(x@pseq@data, x@pseq@target)))





