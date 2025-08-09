getwd()

dir.create("raw_data")
dir.create("clean_data")
dir.create("scripts")
dir.create("results or Tasks")
dir.create("plots etc")

data <- read.csv(file.choose())

View(data)

str(data)

#gender, diagnosis and smoker have incorrect or inconsistent data types.

data$gender_fac <- as.factor(data$gender)
class(data$gender_fac)

data$diagnosis_fac <- as.factor(data$diagnosis)
class(data$diagnosis_fac)

data$smoker_fac <- as.factor(data$smoker)
class(data$smoker_fac)

data$smoker_num <- factor(data$smoker_fac,
                          levels = c("Yes", "No"),
                          labels = c(0, 1, 2))

class(data$smoker_fac)
class(data$smoker)

data$smoker_num <- factor(data$smoker_fac, levels = c("Yes", "No"), labels = c(1, 0))

write.csv(patient_info, file = "results or Tasks/patient_info_clean.data.csv"

          