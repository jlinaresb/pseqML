# TODO:
# methods: pca, tsne and umap
# add tax_level as argument?
# what transformations we need? glomeration before to make analysis?
# sparse pca insted standard pca?
# To implemment hyperparameter tuning for tsne and umap?
# Make more sofisticated plots

#' Principal Component Analysis
#' @param pseqMLR Object of class \code{pseqMLR}
#' @param make_plot Logical value. If TRUE, biplot is showed.
#' levels
setGeneric(
  "pseq_pca",
  function(pseqMLR, make_plot) standardGeneric("pseq_pca"))
setMethod("pseq_pca",
          signature("pseqML"),
          function(pseqMLR, make_plot) {

            # Combine x and y
            x <- get_X(pseqMLR)
            xy <- get_XY(pseqMLR)

            # Fit
            res <- stats::prcomp(x)

            # Plot
            if (make_plot == TRUE) {
              plot <- autoplot(
                res,
                data = xy,
                colour = "target"
              )
              print(plot)
            }

            return(res)
          })


#' t-SNE method
#' @param pseqMLR Object of class \code{pseqMLR}
#' @param make_plot Logical value. If TRUE, biplot is showed.
#' levels
setGeneric(
  "pseq_tsne",
  function(pseqMLR, make_plot) standardGeneric("pseq_tsne"))
setMethod("pseq_tsne",
          signature("pseqML"),
          function(pseqMLR, make_plot) {

            # Combine x and y
            x <- get_X(pseqMLR)
            y <- get_Y(pseqMLR)

            # Data transformation??
            res <- tsne::tsne(x, initial_dims = 2)

            # Plot
            if (make_plot == TRUE) {
              to_plot <- data.frame(
                x = res$Y[, 1],
                y = res$Y[, 2],
                col = y
              )

              plot <- ggplot(to_plot) +
                geom_point(aes(x = x, y = y, color = col))
              print(plot)
            }

            return(res)
          })


#' UMAP method
#' @param pseqMLR Object of class \code{pseqMLR}
#' levels
setGeneric(
  "pseq_umap",
  function(pseqMLR) standardGeneric("pseq_umap"))
setMethod("pseq_umap",
          signature("pseqML"),
          function(pseqMLR) {

            # Combine x and y
            x <- get_X(pseqMLR)

            # Data transformation??
            res <- umap::umap(x, n_components = 2, random_state = 15)

            return(res)
          })
