# utils functions to plot

data_to_plot <- function(
    pseqMLR,
    merged = FALSE
    ) {

  if (merged == TRUE) {
    pseqMLR@data <- merge_samples(
      x = pseqMLR@data,
      group = pseqMLR@target,
      fun = sum
    )

    # Extract data
    otu <- otu_table(pseqMLR@data)
    taxa <- data.frame(
      otus = rownames(tax_table(pseqMLR@data)),
      tax_table(pseqMLR@data)
      )

    # Melt otu data
    otu_melt <- reshape2::melt(otu)
    names(otu_melt) <- c("target", "otus", "counts")

    # Check variable format
    # NOTE: change this part to check-utils!
    # ============
    otu_melt$target <- make.names(as.factor(otu_melt$target))
    otu_melt$otus <- as.character(otu_melt$otus)
    otu_melt$counts <- as.numeric(otu_melt$counts)
    # ============

    # Join datasets
    to_plot <- dplyr::left_join(otu_melt, taxa, by = "otus")

  } else {

    # Extract data
    otu <- otu_table(pseqMLR@data)
    label <- data.frame(
      ids = rownames(sample_data(pseqMLR@data)),
      target = get_variable(pseqMLR@data, pseqMLR@target))
    taxa <- data.frame(
      otus = rownames(tax_table(pseqMLR@data)),
      tax_table(pseqMLR@data))

    # Melt otu data
    otu_melt <- reshape2::melt(otu)
    names(otu_melt) <- c("otus", "ids", "counts")

    # Check variable format
    # NOTE: change this part to check-utils!
    # ============
    label$ids <- make.names(as.character(label$ids))
    otu_melt$ids <- make.names(as.character(otu_melt$ids))
    label$target <- as.factor(label$target)
    otu_melt$otus <- as.character(otu_melt$otus)
    otu_melt$counts <- as.numeric(otu_melt$counts)
    # ============

    # Join datasets
    to_plot <- dplyr::left_join(otu_melt, label, by = "ids")
    to_plot <- dplyr::left_join(to_plot, taxa, by = "otus")
  }

  return(to_plot)
}
