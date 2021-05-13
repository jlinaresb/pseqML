# Accessors Methods
# =================

#' @export get_X
setGeneric('get_X', function(x) standardGeneric('get_X'))
setMethod('get_X', 'pseqML', function(x) as.data.frame(t(x@data@otu_table@.Data)))

#' @export get_Y
setGeneric('get_Y', function(x) standardGeneric('get_Y'))
setMethod('get_Y', 'pseqML', function(x) as.factor(phyloseq::get_variable(x@data, x@target)))





