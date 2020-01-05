translate <- function(x ,terms, from = "french", to = "english", sep = "; ", allow_missing = FALSE) {

# adapted from function trans() in the rosettafish package
# https://github.com/pbs-assess/rosettafish
# this version uses a local custom file of terms, rather than the built in vocab from the package

  from.vec <- terms[, from, drop = TRUE]
  to.df <- terms[, to, drop = FALSE]

  j <- match(x, from.vec)

  if (!allow_missing) {
    if (any(is.na(j))) {
      if (sum(is.na(j)) == 1L)
        stop("The following term is not in the translation database: ", x[is.na(j)],
          call. = FALSE)
      else
        stop("The following terms are not in the translation database: ",
          paste(x[is.na(j)], collapse = ", "), call. = FALSE)
    }
  }
  v <- to.df[j,]
  v[is.na(j)] <- x[is.na(j)]
  if(class(v) == "data.frame"){
    v <- as.character(apply(v, 1, function(x){ paste0(x, collapse = sep)}))
  }
  v
}