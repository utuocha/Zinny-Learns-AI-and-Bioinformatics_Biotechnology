getwd()

classify_gene <- function(logFC, padj) {
  if (logFC > 1 & padj < 0.05) {
    return("Upregulated")
  } else if (logFC < -1 & padj < 0.05) {
    return("Downregulated")
  } else {
    return("Not_Significant")
  }
}

input_dir <- "raw_data"
output_dir <- "results"

files_to_process <- c("DEGs_Data_1.csv", "DEGs_Data_2.csv")
result_list <- list()

for (file_names in files_to_process) {
  cat("\nProcessing:", file_names, "\n")
  
  input_file_path <- file.path(input_dir, file_names)
  
  # Import dataset
  data <- read.csv(input_file_path, header = TRUE)
  cat("File imported. Checking for missing values...\n")
  
  # handling missing values
  
  if("padj" %in% names(data)){
    missing_count <- sum(is.na(data$padj))
    
    cat("Missing values in 'padj':", missing_count, "\n")
    data$padj[is.na(data$padj)] <- 1
  }
  # classify gene
  data$gene <- classify_gene(data$logFC, data$padj)
  cat("gene has been classified successfully.\n")
  
  # save results in R
  result_list[[file_names]] <- data 
  
  # save results in Results folder
  output_file_path <- file.path(output_dir, paste0("gene_results", file_names))
  write.csv(data, output_file_path, row.names = FALSE)
  cat("Results saved to:", output_file_path, "\n")
}

# CODE ABOVE RETURNED ERRORS SO RED-DOING IT BELOW

classify_gene <- function(logFC, padj) {
  ifelse(logFC > 1 & padj < 0.05, "Upregulated",
         ifelse(logFC < -1 & padj < 0.05, "Downregulated",
                "Not_Significant"))
}
input_dir <- "raw_data"
output_dir <- "Results"
if(!dir.exists(output_dir)){
  dir.create(output_dir)
}

files_to_process <- c("DEGs_Data_1.csv", "DEGs_Data_2.csv")
result_list <- list()

for (file_names in files_to_process) {
  cat("\nProcessing:", file_names, "\n")
  
  input_file_path <- file.path(input_dir, file_names)
  
  # Import dataset
  data <- read.csv(input_file_path, header = TRUE)
  cat("File imported. Checking for missing values...\n")
  
  # handling missing values
  
  if("padj" %in% names(data)){
    missing_count <- sum(is.na(data$padj))
    
    cat("Missing values in 'padj':", missing_count, "\n")
    data$padj[is.na(data$padj)] <- 1
  }
  # classify gene
  data$gene <- classify_gene(data$logFC, data$padj)
  cat("gene has been classified successfully.\n")
  
  # save results in R
  result_list[[file_names]] <- data 
  
  # save results in Results folder
  output_file_path <- file.path(output_dir, paste0("gene_results", file_names))
  write.csv(data, output_file_path, row.names = FALSE)
  cat("Results saved to:", output_file_path, "\n")
  
  # print summary  count
  cat("Summary:\n")
  
  #use tables for summaries
  print(table(data$gene))
}

results_1 <- result_list[[1]]
results_2 <- result_list[[2]]
