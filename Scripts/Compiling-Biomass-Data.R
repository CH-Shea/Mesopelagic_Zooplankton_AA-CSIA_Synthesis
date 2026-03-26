library(readxl)

# Loading EQ Pac and ALOHA data available in Romero-Romero et al 2020
Biomass_Romero <- read_excel("C:/Users/chshea/OneDrive/Documents/University_of_Hawaii/SIA_work/EXPORTS/Data/5N-8N-ALOHA/Particles and zooplankton AACSIA_Romero.xlsx", 
                                                      sheet = "Data")
colnames(Biomass_Romero)[colnames(Biomass_Romero) == "SizeFraction_min"] <- "Sizemin"
Biomass_Romero <- subset(Biomass_Romero, Type == "Zooplankton")
Biomass_Romero$Biomass <- as.numeric(Biomass_Romero$Biomass)
Biomass_Romero <- Biomass_Romero[!is.na(Biomass_Romero$Biomass),]
Biomass_Romero[which(Biomass_Romero$Site == "ALOHA"),]$Site <- 
  do.call(paste, c(Biomass_Romero[Biomass_Romero$Site == "ALOHA",c("Site","Season")], sep=" "))
Biomass_Romero$Depth <- as.numeric(Biomass_Romero$Depth)
Biomass_Romero$Sizemin <- as.numeric(Biomass_Romero$Sizemin)

Biomass_Romero <- aggregate(
  x = Biomass ~ Depth + Site + DayNight + Sizemin,
  data = Biomass_Romero,
  FUN = mean
)


# Loading Station Papa data available in Shea et al 2023
Biomass_OSP <- read_excel("C:/Users/chshea/OneDrive/Documents/University_of_Hawaii/SIA_work/EXPORTS/Data/OSP/AA Data - clean and current/ZooplanktonBiomassClosePopp.xlsx")
colnames(Biomass_OSP)[colnames(Biomass_OSP) == "Density"] <- "Biomass"
colnames(Biomass_OSP)[colnames(Biomass_OSP) == "SizeFraction"] <- "Sizemin"
Biomass_OSP <- Biomass_OSP[!is.na(Biomass_OSP$Biomass),]
Biomass_OSP$Depth <- strsplit(Biomass_OSP$DepthInterval,"-")
for (i in 1:nrow(Biomass_OSP)) {
  Biomass_OSP$Depth[i] <-
    mean(as.double(Biomass_OSP$Depth[i][[1]]))
}
Biomass_OSP$Depth <- as.double(Biomass_OSP$Depth)
Biomass_OSP$Site <- "Station Papa"

Biomass_OSP <- aggregate(
  x = Biomass ~ Depth + Site + DayNight + Sizemin,
  data = Biomass_OSP,
  FUN = mean
)


# Loading North Atlantic data available in Steinberg et al (in prep)
Biomass_PAP <- read_excel("C:/Users/chshea/OneDrive/Documents/University_of_Hawaii/SIA_work/EXPORTS/Data/PAP/Zooplankton Biomass and Bulk SIA.xlsx")
colnames(Biomass_PAP)[colnames(Biomass_PAP) == "BiomassConcDry"] <- "Biomass"
colnames(Biomass_PAP)[colnames(Biomass_PAP) == "Event"] <- "DayNight"
# Biomass_PAP <- subset(Biomass_PAP, Epoch == "Epoch 3")
Biomass_PAP <- subset(Biomass_PAP, Sizemin != 9900)
Biomass_PAP <- Biomass_PAP[!is.na(Biomass_PAP$Biomass),]
Biomass_PAP$Biomass <- Biomass_PAP$Biomass * 1000
Biomass_PAP$Site <- "North Atlantic"

Biomass_PAP <- aggregate(
  x = Biomass ~ Depth + Site + DayNight + Sizemin,
  data = Biomass_PAP,
  FUN = mean
)


# Aggregating all sites into one dataframe
Biomass_all <- rbind(Biomass_Romero, Biomass_OSP, Biomass_PAP)
Biomass_all$Sizemin <- as.factor(Biomass_all$Sizemin)

Biomass_wide <-
  reshape(Biomass_all, 
          idvar = c("Site", "Depth", "DayNight"), 
          timevar = "Sizemin", 
          direction = "wide")
Biomass_wide$Biomass.all <- 
  rowSums(Biomass_wide[4:8])

BiomassProp_wide <- Biomass_wide
for (i in 4:8) {
  BiomassProp_wide[i] <- BiomassProp_wide[i]/BiomassProp_wide[9]
}

library(ggplot2)

ggplot(
  data = subset(Biomass_all, DayNight == "Night")
) +
  geom_col(
    aes(x = Depth, y = Biomass, fill = Sizemin)
  ) +
  facet_wrap(~ Site, scales = "free_x")

ggplot(
  data = subset(Biomass_all, DayNight == "Night")
) +
  geom_col(
    aes(x = Depth, y = Biomass, fill = Sizemin),
    position = "fill"
  ) +
  facet_wrap(~ Site, scales = "free_x")+
  ggtitle("Nighttime")

ggplot(
  data = subset(Biomass_all, DayNight == "Day")
) +
  geom_col(
    aes(x = Depth, y = Biomass, fill = Sizemin),
    position = "fill"
  ) +
  facet_wrap(~ Site, scales = "free_x")+
  ggtitle("Daytime")


# pooling all data below 100 m

Biomass_day <- aggregate(
  x = Biomass ~ Site + DayNight,
  data = subset(Biomass_all, Depth < 100 & DayNight == "Day"),
  FUN = sum
)
Biomass_night <- aggregate(
  x = Biomass ~ Site + DayNight,
  data = subset(Biomass_all, Depth < 100 & DayNight == "Night"),
  FUN = sum
)
Biomass_migrating <- Biomass_night
Biomass_migrating$Biomass <- Biomass_night$Biomass - Biomass_day$Biomass
Biomass_migrating$Proportion <- Biomass_night$Biomass/Biomass_day$Biomass
Biomass_migrating

ggplot(
  data = subset(Biomass_deep, DayNight == "Night"),
) +
  geom_bar(
    aes(x='', y=Biomass, fill = Sizemin),
    stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  facet_wrap(~ Site, scales = "free")+
  theme_void()

# Let's look at the porportion of the zooplankton community below 100 m (night) that migrates
Biomass_deep_pooled <- aggregate(
  x = Biomass ~ Site + DayNight,
  data = Biomass_deep,
  FUN = sum
)

Biomass_deep_pooled$Biomass[1:6]

Biomass_night_mpz <- aggregate(
  x = Biomass ~ Site + DayNight + Depth,
  data = subset(Biomass_all, Depth > 200 & Depth < 750 & DayNight == "Night"),
  FUN = sum
)
Biomass_night_mpz <- aggregate(
  x = Biomass ~ Site + DayNight,
  data = subset(Biomass_night_mpz, Depth > 200 & Depth < 750 & DayNight == "Night"),
  FUN = mean
)

Biomass_day_mpz <- aggregate(
  x = Biomass ~ Site + DayNight + Depth,
  data = subset(Biomass_all, Depth > 200 & Depth < 750 & DayNight == "Day"),
  FUN = sum
)
Biomass_day_mpz <- aggregate(
  x = Biomass ~ Site + DayNight,
  data = subset(Biomass_day_mpz, Depth > 200 & Depth < 750 & DayNight == "Day"),
  FUN = mean
)
