# Machine Learning Methods
# ========================

#### pseq2mlr
#' Convert \code{phyloseq} to \code{mlr3} task 
#' @param phyloseq Object of class \code{phyloseq} (required)
#' @param target Character with the name of dependent variable (required)
#' @param id Character vector with ID to data (required)
#' @export
setGeneric('pseq2mlr', function(phyloseq, target, id) standardGeneric('pseq2mlr'))
setMethod('pseq2mlr',
    signature('phyloseq'),
    function(phyloseq, target, id){

        pseqML = new('pseqML', data = phyloseq, target = target)

        X = as.data.frame(t(pseqML@data@otu_table@.Data))
        Y = as.factor(phyloseq::get_variable(pseqML@data, pseqML@target))

        d = cbind.data.frame(X, target = Y)
        names(d) = make.names(names(d))

        task = TaskClassif$new(id = id,
            backend = d,
            target = 'target')

        pseqMLR = new('pseqMLR', 
            pseq = pseqML,
            task = task)

        return(pseqMLR)
        })


### setHyperparameters
#' Initialize a model with a set of hyperparameers
#' @param object of class \code{model} (required)
#' @param object of class \code{inner} (required)
#' @export
setGeneric('setHyperparameters', function(model, inner, search) standardGeneric('setHyperparameters'))
setMethod('setHyperparameters',
    signature('model'),
    function(model, inner, search){

        name = model@l
        learner = lrn(name, predict_type = 'prob', predict_sets = c('train', 'test'))

        if (name == 'classif.kknn'){
            ps = ps(
                k = p_int(lower = model@ps$k[[1]], upper =model@ps$k[[2]]))
        } else if (name == 'classif.glmnet'){
            ps = ps(
                alpha = p_dbl(lower = model@ps$alpha[[1]], upper =model@ps$alpha[[2]]),
                s = p_dbl(lower = model@ps$s[[1]], upper = model@ps$s[[2]]))
        } else if (name == 'classif.naive_bayes'){
            ps = ps(
                laplace = p_dbl(lower = model@ps$laplace[[1]], upper = model@ps$laplace[[2]]))
        } else if (name == 'classif.ksvm'){
            ps = ps(
                C = p_dbl(lower = model@ps$C[[1]], upper = model@ps$C[[2]]),
                sigma = p_dbl(lower = model@ps$sigma[[1]], upper = model@ps$sigma[[2]]))
        } else if (name == 'classif.xgboost'){
            ps = ps(
                nrounds = p_int(lower = model@ps$nrounds[[1]], upper = model@ps$nrounds[[2]]),
                max_depth = p_int(lower = model@ps$max_depth[[1]], upper = model@ps$max_depth[[2]]),
                eta = p_dbl(lower = model@ps$eta[[1]], upper = model@ps$eta[[2]]),
                lambda = p_dbl(lower = model@ps$lambda[[1]], upper = model@ps$lambda[[2]], trafo = model@ps$lambda[[3]]))
        } else if (name == 'classif.randomForest'){
            ps = ps(
                ntree = p_int(lower = model@ps$ntree[[1]], upper = model@ps$ntree[[2]]),
                mtry = p_int(lower = model@ps$mtry[[1]], upper = model@ps$mtry[[2]]),
                nodesize = p_int(lower = model@ps$nodesize[[1]], upper = model@ps$nodesize[[2]]))
        }

        measure = msr(search@measure)
        terminator = trm(search@terminator[[1]], n_evals = search@terminator[[2]])
        tuner = tnr(search@tuner[[1]], resolution = search@tuner[[2]])

        at = AutoTuner$new(learner, inner, measure, terminator, tuner, ps)

        })


### Initialize resampling class
#' Initialize a resampling class
#' @param object of class \code{resampling} (required)
#' @export
setGeneric('init_resampling', function(object) standardGeneric('init_resampling'))
setMethod('init_resampling',
    signature('resampling'),
    function(object){

        strategies = c('bootstrap', 'cv', 'holdout', 'loo', 'repeated_cv')
        stopifnot(object@resampling %in% strategies)

        if (object@resampling == 'bootstrap'){
            rs = rsmp(object@resampling, repeats = object@repeats, ratio = object@ratio)
        } else if (object@resampling == 'cv'){
            rs = rsmp(object@resampling, folds = object@folds)
        } else if (object@resampling == 'holdout'){
            rs = rsmp(object@resampling, ratio = object@ratio)
        } else if (object@resampling == 'loo'){
            rs = rsmp(object@resampling)
        } else if (object@resampling == 'repeated_cv'){
            rs = rsmp(object@resampling, repeats = object@repeats, folds = object@folds)
        }

        return(rs)

        })






