### TODO ###
# - Añadir a filterFS el selectFeatures()
# - Check vignette
# - Correr todas con un ejemplo
# - Hacer checking para CFS si la matriz es muy grande



# Export functions
# ======================
#' Feature Selection - FILTER
#' @param pseqMLR \code{pseqML} object
#' @param method Character vector with methods availables in \code{listFilterMethods}
#' @export
filterFS = function(pseqMLR, method){

	filtMethods = listFilterMethods()

	res = list()
	for (i in seq_along(method)) {
		stopifnot(method[i] %in% filtMethods)
		filter = flt(method[i])
		res[[i]] = filter$calculate(pseqMLR@task)
	}

	names(res) = methods

	return(res)
}


#' Feature Selection - CFS
#' @param cutoff Numeric value between 0-1 of correlation
#' @param pseqMLR \code{pseqML} object
#' @export filterCFS
filterCFS  = function(pseqMLR, cutoff){

	X = get_X(pseqMLR)
	Y = get_Y(pseqMLR)

	res = cor(X)
	remove = caret::findCorrelation(res, cutoff = cutoff, exact = F)

	if (length(remove) > 0){
		out = X[, -remove]
		featus = names(out)
		pseqMLR = selectFeatures(pseqMLR, featus)
	} else {
		cat('There is no variables to remove!')
	}

	return(pseqMLR)
}


#' Feature Selection - Markov Blanket Filter
#' @param cutoff Numeric value between 0-1 of correlation
#' @param pseqMLR \code{pseqML} object
#' @export
filterMBF = function(pseqMLR, max_k = 3, threshold = 0.05, test = 'testIndFisher', ncores = 2){

	X = get_X(pseqMLR)
	X.m = as.matrix(X)
	Y = get_Y(pseqMLR)

	res = mmmb(target = Y,
	 dataset = X.m,
	 max_k = max_k,
	 threshold = threshold, 
	 test = test,
	 user_test = NULL,
	 ncores = ncores)

	vars = res$mb
	DataFilt = selectFeatures(pseqMLR, vars)

	return(DataFilt)
}


#' Feature Selection - Fast Correlation Based Feature Selection
#' @param pseqMLR \code{pseqML} object
#' @param threshold  Numeric value indicating the minimum correlation (as determined by symettrical uncertainty) between each variable and the class
#' @export
filterMBF = function(pseqMLR, threshold){

	X = get_X(pseqMLR)
	X.m = as.matrix(X)

	dis = discretize_exprs(t(X))
	fcbf = fcbf(dis, y, verbose = T, thresh = threshold)

	res = X[, fcbf$index]
	featus = names(res)
	res = selectFeatures(pseqMLR, featus)
	
	return(res)
}


#' Training a ML algorithm
#' @param task Task created with \code{pseq2mlr} method
#' @param learner Learner created with \code{setHyperparameters} method
#' @param predict Logical value. If \code{predict = TRUE} a test tasks must be provided
#' @param test Task created with \code{pseq2mlr} method
#' @return a Train object generated from \code{mlr3}
#' @export
trainML = function(task, learner, predict = F, test = NULL){

	res = learner$train(task)

	if (predict == T){
		res = learner$predict(test)
	}

	return(res)
}


#' Carry out a resampling strategy
#' @param task Task created with \code{pseq2mlr} method
#' @param learner Learner created with \code{setHyperparameters} method
#' @param outer Resampling object initialized with \code{init_resampling} method
#' @return a BenchmarkResult object generated from \code{mlr3}
#' @export
rsmplML = function(task, learner, outer){

	res = resample(task, learner, outer, store_models = TRUE)

	return(res)
}



#' Run a Benchmark experiment
#' @param tasks List of tasks created with \code{pseq2mlr} method
#' @param learners List of learners created with \code{setHyperparameters} method
#' @param outer Resampling object initialized with \code{init_resampling} method
#' @return a BenchmarkResult object generated from \code{mlr3}
#' @export
benchML = function(tasks, learners, outer){

        grid = benchmark_grid(
            task = tasks,
            learner = learners,
            resampling = outer
            )

        bmr = benchmark(grid)

        return(bmr)
}