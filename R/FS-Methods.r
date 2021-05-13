#' Method to select features of a \code{pseqMLR} object
#' @param pseqMLR Object of class \code{pseqMLR}
#' @param features Character vector of samples to be kept
setGeneric('selectFeatures', function(pseqMLR, features) standardGeneric('selectFeatures'))
setMethod('selectFeatures',
	signature('pseqMLR'),
	function(pseqMLR, features){

		prune = prune_taxa(taxa = features, x = pseqMLR@data)
		pseqML = new('pseqML', data = prune, target = pseqMLR@target)

		X = get_X(pseqML)
		Y = get_Y(pseqML)
		d = cbind.data.frame(X, target = Y)
		names(d) = make.names(names(d))					#setValidity()

		task = TaskClassif$new(id = pseqMLR@task$id,
			backend = d,
			target = 'target')

		res = new('pseqMLR', data = pseqML@data, target = pseqML@target, task = task)

		return(res)
		})