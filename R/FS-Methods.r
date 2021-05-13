#' Method to select features of a \code{pseqMLR} object
#' @param pseqMLR Object of class \code{pseqMLR}
#' @param features Character vector of samples to be kept
setGeneric('selectFeatures', function(pseqMLR, features) standardGeneric('selectFeatures'))
setMethod('selectFeatures',
	signature('pseqMLR'),
	function(pseqMLR, features){

		prune = prune_taxa(taxa = features, x = pseqMLR@pseq@data)

		pseqML = new('pseqML', data = prune, target = pseqMLR@pseq@target)

		X = get_X1(pseqML)
		Y = get_Y1(pseqML)
		d = cbind.data.frame(X, target = Y)
		names(d) = make.names(names(d))

		task = TaskClassif$new(id = pseqMLR@task$id,
			backend = d,
			target = 'target')

		res = new('pseqMLR', pseq = pseqML, task = task)

		return(res)
		})