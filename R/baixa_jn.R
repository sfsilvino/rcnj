#' Baixa dados do Justica em Numeros do CNJ
#' 
#' @export
load_jn <- function(justica = 'estadual', path = NULL) {
  link <- 'http://www.cnj.jus.br/images/pesquisas-judiciarias/Base_de_dados/base_de_dados_jn2014.zip'
  if(is.null(path)) {
    path <- system.file('extdata/', package = 'rcnj')
  }
  a <- sprintf('%s/jn.zip', path)
  download.file(link, destfile = a)
  unzip(a, exdir = paste0(path, '/'))
  file.remove(a)
  l <- list.files(path, full.names = TRUE)
  l0 <- tolower(list.files(path))
  ind <- grep(sprintf('_%s_', justica), l0)
  d <- read.csv2(l[ind], stringsAsFactors = FALSE, encoding = 'latin1', dec = ',')
  d
}

#' Baixa glossario estadual
#' 
#' @export
load_glossario_estadual <- function(path = NULL) {
  #   link <- 'http://www.cnj.jus.br/images/pesquisas-judiciarias/Lista_de_variveis_Res.76_-_TJ.xls'
  #   if(is.null(path)) {
  #     path <- system.file('extdata/', package = 'rcnj')
  #   }
  #   a <- sprintf('%s/glossario_estadual.xls', path)
  #   download.file(link, destfile = a)
  d <- gdata::read.xls(a, stringsAsFactors = FALSE, encoding = 'latin1', header = FALSE)
  d <- tidyr::separate(d, V1, c('name', 'descr'), sep = ' - ')
  d$name <- gsub('\\?', '', abjutils::rm_accent(tolower(d$name)))
  # file.remove(a)
  d
}
