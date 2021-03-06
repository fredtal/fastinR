#' @S3method print Fatty_Acid_Profiles
print.Fatty_Acid_Profiles <- function(x, ...){
   cat('Fatty Acid profile data with:','\n')
   cat(x$n.preds,' Predators','\n')
   cat(x$n.preys,' Prey species','\n')
   cat('Profiles containing ',x$datas.FA$n.fats,' Fatty Acids','\n')
}

#' @S3method print Stable_Isotopes
print.Stable_Isotopes <- function(x, ...){
  cat('Stable Isotope data with:','\n')
  cat(x$n.preds,' Predators','\n')
  cat(x$n.preys,' Prey species','\n')
  cat(x$datas.SI$isos,' Stable Isotopes','\n')
}


#' @S3method print Combined_Markers
print.Combined_Markers <- function(x, ...){
  cat('Combined marker data with:','\n')
  cat(x$n.preds,' Predators','\n')
  cat(x$n.preys,' Prey species','\n')
  cat('Profiles containing ',x$datas.FA$n.fats,' Fatty Acids','\n')
  cat('and ',x$datas.SI$isos,' Stable Isotopes','\n')
  
}
