#' Plot heatmap of relative abundances according response variable
#' @param pseqMLR Object of class \code{pseqMLR}
setGeneric(
  "plot_heatmap",
  function(pseqMLR) standardGeneric("plot_heatmap"))
setMethod("plot_heatmap",
          signature("pseqMLR"),
          function(pseqMLR) {

            # Format data to plot
            to_plot <- data_to_plot(
              pseqMLR,
              merged = FALSE)
            # Plotting heatmap
            plot <- ggplot(
              to_plot,
              aes(ids, otus, fill= counts)) +
              facet_wrap(~target, scales = "free_x") +
              geom_tile() +
              theme(
                axis.text.x = element_text(angle = 45, hjust = 1)
              )
            print(plot)
            return(plot)
          })


#' Plot abundances according response variable
#' @param pseqMLR Object of class \code{pseqMLR}
#' @param tax_level Character vector. Name of one of the taxonomic
#' levels
setGeneric(
  "plot_abundances_by_target",
  function(pseqMLR) standardGeneric("plot_abundances_by_target"))
setMethod("plot_abundances_by_target",
          signature("pseqMLR"),
          function(pseqMLR) {

            # Format data to plot
            to_plot <- data_to_plot(
              pseqMLR,
              merged = TRUE
            )
            # Plotting barplot
            plot <- ggplot(
              to_plot,
              aes(x = target, y = counts)) +
              geom_bar(
                aes_string(fill = tax_level),
                stat = "identity")
            print(plot)
            return(plot)
          })

