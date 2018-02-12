
save_html_from_url <-
  function(url = NULL,
           save_dir = NULL,
           save_file_name_w_ext = NULL) {

    if(is.null(url) ||
       is.null(save_dir) ||
       is.null(save_file_name_w_ext)) {
      stop("missing required_input")
    }

    msg_end <-
      paste0(
        "HTML contents retrieved from\n",
        url,
        ".\nHTML contents saved as ",
        save_file_name_w_ext,
        "\nin ",
        save_dir,
        ".\n"
      )
    try(download.file(url, destfile = paste0(save_dir, save_file_name_w_ext)))
    paste0(save_dir, save_file_name_w_ext)
  }

get_stats_from_html <- function(html_file = NULL, node = "table", has_header = TRUE) {
  require("dplyr")
  require("rvest")

  if(is.null(html_file) | is.null(node)) {
    stop()
  }

  d <-
    html_file %>%
    read_html %>%
    html_nodes(node) %>%
    html_table(header = has_header) %>%
    data.frame() %>%
    tbl_df()

}

