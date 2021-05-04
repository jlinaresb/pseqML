# Export functions
# ======================

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