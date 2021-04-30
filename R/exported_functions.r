# Export functions
# ======================

#' Run a Benchmark experiment
#' @param tasks List of tasks created with \code{pseq2mlr} method
#' @param learners List of learners created with \code{setHyperparameters} method
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