library(dplyr)
library(ggplot2)
library(colorspace)
library(scales)

df = read.csv('sandbox.csv') %>% select(-X)
dim(df)
head(df)
names(df)

df = df %>% mutate(Neighborhood = ifelse(Neighborhood == 'Blmngtn', "Bloomington Heights",
                      ifelse(Neighborhood == 'Blueste', "Bluestem",
                      ifelse(Neighborhood == 'BrDale', "Briardale",
                      ifelse(Neighborhood == 'BrkSide', "Brookside",
                      ifelse(Neighborhood == 'ClearCr', "Clear Creek",
                      ifelse(Neighborhood == 'CollgCr', "College Creek",
                      ifelse(Neighborhood == 'Crawfor', "Crawford",
                      ifelse(Neighborhood == 'Edwards', "Edwards",
                      ifelse(Neighborhood == 'Gilbert', "Gilbert",
                      ifelse(Neighborhood == 'IDOTRR', "Iowa DOT & Rail Road",
                      ifelse(Neighborhood == 'MeadowV', "Meadow Village",
                      ifelse(Neighborhood == 'Mitchel', "Mitchell",
                      ifelse(Neighborhood == 'Names', "North Ames",
                      ifelse(Neighborhood == 'NoRidge', "Northridge",
                      ifelse(Neighborhood == 'NPkVill', "Northpark Villa",
                      ifelse(Neighborhood == 'NridgHt', "Northridge Heights",
                      ifelse(Neighborhood == 'NWAmes', "Northwest Ames",
                      ifelse(Neighborhood == 'OldTown', "Old Town",
                      ifelse(Neighborhood == 'SWISU', "South & West of ISU",
                      ifelse(Neighborhood == 'Sawyer', "Sawyer",
                      ifelse(Neighborhood == 'SawyerW', "Sawyer West",
                      ifelse(Neighborhood == 'Somerst', "Somerset",
                      ifelse(Neighborhood == 'StoneBr', "Stone Brook",
                      ifelse(Neighborhood == 'Timber', "Timberland", "Veenker")))))))))))))))))))))))))

###########################################################

# Sale Price - Median
median_sale_price = df %>% 
  group_by(Neighborhood) %>% 
  summarize(med_price = median(SalePrice)/1e3) %>% 
  arrange(desc(med_price)) 

ggplot(median_sale_price, aes(Neighborhood, med_price)) +
  geom_col(aes(reorder(Neighborhood, -med_price), fill=Neighborhood), position='dodge') +
  scale_fill_discrete_sequential(palette = "Blues") +
  ggtitle('\nMedian Home Price by Neighborhood', 'Homes sold between 2006-2010') +
  xlab('\nNeighborhood\n') +
  ylab('Median Sale Price') +
  theme(plot.title = element_text(color="grey10", size=18, face="bold"),
        plot.subtitle = element_text(color="grey10", size=12),
        axis.ticks = element_blank(),
        axis.text.x = element_text(color="grey10", size=12, angle=90, hjust=0.95),
        axis.text.y = element_text(color="grey10", size=12),
        axis.title.x = element_text(color="grey10", size=14, face="bold"),
        axis.title.y = element_text(color="grey10", size=14, face="bold"),
        legend.position = 'none') +
  #scale_y_continuous(labels = scales::label_comma()) + 
  scale_y_continuous(labels = scales::dollar_format(prefix="$", suffix="K"))
  theme(legend.position="none")

###########################################################

# Square Footage - Median
median_sf = df %>% 
  group_by(Neighborhood) %>% 
  summarize(med_sf = median(GrLivArea + BsmtFinSF1 + BsmtFinSF2)) %>% 
  arrange(desc(med_sf)) 

ggplot(median_sf, aes(Neighborhood, med_sf)) +
  geom_col(aes(reorder(Neighborhood, -med_sf), fill=Neighborhood), position='dodge') +
  scale_fill_discrete_sequential(palette = "Blues") +
  ggtitle('\nMedian Square Feet by Neighborhood', 'Homes sold between 2006-2010') +
  xlab('\nNeighborhood\n') +
  ylab('Total Square Feet') +
  theme(plot.title = element_text(color="grey10", size=18, face="bold"),
        plot.subtitle = element_text(color="grey10", size=12),
        axis.ticks = element_blank(),
        axis.text.x = element_text(color="grey10", size=12, angle=90, hjust=0.95),
        axis.text.y = element_text(color="grey10", size=12),
        axis.title.x = element_text(color="grey10", size=14, face="bold"),
        axis.title.y = element_text(color="grey10", size=14, face="bold"),
        legend.position = 'none') +
  scale_y_continuous(labels = scales::label_comma()) + 
  #scale_y_continuous(labels = scales::dollar_format(prefix="$"))
  theme(legend.position="none")

###########################################################

# Price per Square Foot - Median
median_price_sf = df %>% 
  group_by(Neighborhood) %>% 
  summarize(med_price_per_sqfoot = median(SalePrice)/median(GrLivArea + BsmtFinSF1 + BsmtFinSF2)) %>% 
  arrange(desc(med_price_per_sqfoot))

ggplot(median_price_sf, aes(Neighborhood, med_price_per_sqfoot)) +
  geom_col(aes(reorder(Neighborhood, -med_price_per_sqfoot), fill=Neighborhood), position='dodge') +
  scale_fill_discrete_sequential(palette = "Blues") +
  ggtitle('\nMedian Price per Square Foot by Neighborhood', 'Homes sold between 2006-2010') +
  xlab('\nNeighborhood\n') +
  ylab('Price per Square Foot') +
  theme(plot.title = element_text(color="grey10", size=18, face="bold"),
        plot.subtitle = element_text(color="grey10", size=12),
        axis.ticks = element_blank(),
        axis.text.x = element_text(color="grey10", size=10, angle=90, hjust=0.98),
        axis.text.y = element_text(color="grey10", size=12),
        axis.title.x = element_text(color="grey10", size=14, face="bold"),
        axis.title.y = element_text(color="grey10", size=14, face="bold"),
        legend.position = 'none') +
  #scale_y_continuous(labels = scales::label_comma()) + 
  scale_y_continuous(labels = scales::dollar_format(prefix="$"))
  theme(legend.position="none")

###########################################################
# # Bedrooms - Meidan
# median_bedrooms = df %>% 
#   group_by(Neighborhood) %>% 
#   summarize(med_bedrooms = median(BedroomAbvGr)) %>% 
#   arrange(desc(med_bedrooms))
# 
# ggplot(median_bedrooms, aes(Neighborhood, med_bedrooms)) +
#   geom_col(aes(reorder(Neighborhood, -med_bedrooms), fill=Neighborhood), position='dodge') +
#   scale_fill_discrete_sequential(palette = "Blues") +
#   ggtitle('\nMedian Bedrooms by Neighborhood', 'Homes sold between 2006-2010') +
#   xlab('\nNeighborhood\n') +
#   ylab('Number of Bedrooms') +
#   theme(plot.title = element_text(color="grey10", size=18, face="bold"),
#         plot.subtitle = element_text(color="grey10", size=12),
#         axis.ticks = element_blank(),
#         axis.text.x = element_text(color="grey10", size=10, angle=90, hjust=0.98),
#         axis.text.y = element_text(color="grey10", size=12),
#         axis.title.x = element_text(color="grey10", size=14, face="bold"),
#         axis.title.y = element_text(color="grey10", size=14, face="bold"),
#         legend.position = 'none') +
#   scale_y_continuous(labels = scales::label_comma()) + 
#   #scale_y_continuous(labels = scales::dollar_format(prefix="$"))
# theme(legend.position="none")

###########################################################  

  
# # Bathrooms - Median
# median_bathrooms = df %>% 
#   group_by(Neighborhood) %>% 
#   summarize(med_bathrooms = median(FullBath+HalfBath + BsmtFullBath + BsmtHalfBath)) %>% 
#   arrange(desc(med_bathrooms))

  
########################################################### 

# median_overall_quality = df %>% 
#   group_by(Neighborhood) %>% 
#   summarize(med_quality = median(OverallQual)) %>% 
#   arrange(desc(med_quality))
# 
# ggplot(median_overall_quality, aes(Neighborhood, med_quality)) +
#   geom_col(aes(reorder(Neighborhood, -med_quality), fill=Neighborhood), position='dodge') +
#   scale_fill_discrete_sequential(palette = "Blues") +
#   ggtitle('\nMedian Overall Quality by Neighborhood', 'Homes sold between 2006-2010') +
#   xlab('\nNeighborhood\n') +
#   ylab('Overall Quality') +
#   theme(plot.title = element_text(color="grey10", size=18, face="bold"),
#         plot.subtitle = element_text(color="grey10", size=12),
#         axis.ticks = element_blank(),
#         axis.text.x = element_text(color="grey10", size=10, angle=90, hjust=0.98),
#         axis.text.y = element_text(color="grey10", size=12),
#         axis.title.x = element_text(color="grey10", size=14, face="bold"),
#         axis.title.y = element_text(color="grey10", size=14, face="bold"),
#         legend.position = 'none') +
#   scale_y_continuous(labels = scales::label_comma()) + 
#   #scale_y_continuous(labels = scales::dollar_format(prefix="$")) + 
#   theme(legend.position="none")


###########################################################

# Lot Size (Acres) - Median
median_lot = df %>% 
  group_by(Neighborhood) %>% 
  summarize(med_lot = round(median(LotArea)/43560, 2)) %>% 
  arrange(desc(med_lot))

  ggplot(median_lot, aes(Neighborhood, med_lot)) +
    geom_col(aes(reorder(Neighborhood, -med_lot), fill=Neighborhood), position='dodge') +
    scale_fill_discrete_sequential(palette = "Blues") +
    ggtitle('\nMedian Acres per Lot by Neighborhood', 'Homes sold between 2006-2010') +
    xlab('\nNeighborhood\n') +
    ylab('Acres') +
    theme(plot.title = element_text(color="grey10", size=18, face="bold"),
          plot.subtitle = element_text(color="grey10", size=12),
          axis.ticks = element_blank(),
          axis.text.x = element_text(color="grey10", size=10, angle=90, hjust=0.98),
          axis.text.y = element_text(color="grey10", size=12),
          axis.title.x = element_text(color="grey10", size=14, face="bold"),
          axis.title.y = element_text(color="grey10", size=14, face="bold"),
          legend.position = 'none') +
    scale_y_continuous(labels = scales::label_comma()) 
    #scale_y_continuous(labels = scales::dollar_format(prefix="$")) 

###########################################################
  
# Price per Acre - Median
median_price_acre = df %>% 
  group_by(Neighborhood) %>% 
  summarize(med_price_per_acre = median(SalePrice)/(median(LotArea)/43560)/1e6) %>% 
  arrange(desc(med_price_per_acre)) 

ggplot(median_price_acre, aes(Neighborhood, med_price_per_acre)) +
  geom_col(aes(reorder(Neighborhood, -med_price_per_acre), fill=Neighborhood), position='dodge') +
  scale_fill_discrete_sequential(palette = "Blues") +
  ggtitle('\nMedian Cost per Acre by Neighborhood', 'Homes sold between 2006-2010') +
  xlab('\nNeighborhood\n') +
  ylab('Cost per Acre') +
  theme(plot.title = element_text(color="grey10", size=18, face="bold"),
        plot.subtitle = element_text(color="grey10", size=12),
        axis.ticks = element_blank(),
        axis.text.x = element_text(color="grey10", size=10, angle=90, hjust=0.98),
        axis.text.y = element_text(color="grey10", size=12),
        axis.title.x = element_text(color="grey10", size=14, face="bold"),
        axis.title.y = element_text(color="grey10", size=14, face="bold"),
        legend.position = 'none') +
  # scale_y_continuous(labels = scales::label_comma()) +
  scale_y_continuous(labels = scales::dollar_format(prefix="$", suffix = "M")) 
  
###########################################################

# Cars in Garage - Median
meidan_car_garage = df %>% 
  group_by(Neighborhood) %>% 
  summarize(med_car_garage = median(GarageCars)) %>%
  arrange(desc(med_car_garage)) 

###########################################################

# Year Built - Median
median_yr_built = df %>% 
  group_by(Neighborhood) %>% 
  summarize(med_yr_built = median(YearBuilt)) %>% 
  arrange(desc(med_yr_built)) 

ggplot(median_yr_built, aes(Neighborhood, med_yr_built)) +
  geom_col(aes(reorder(Neighborhood, -med_yr_built), fill=Neighborhood), position='dodge') +
  scale_fill_discrete_sequential(palette = "Blues") +
  ggtitle('\nMedian Year Built by Neighborhood', 'Homes sold between 2006-2010') +
  xlab('\nNeighborhood\n') +
  ylab('Year') +
  theme(plot.title = element_text(color="grey10", size=18, face="bold"),
        plot.subtitle = element_text(color="grey10", size=12),
        axis.ticks = element_blank(),
        axis.text.x = element_text(color="grey10", size=10, angle=90, hjust=0.98),
        axis.text.y = element_text(color="grey10", size=12),
        axis.title.x = element_text(color="grey10", size=14, face="bold"),
        axis.title.y = element_text(color="grey10", size=14, face="bold"),
        legend.position = 'none') +
  scale_y_continuous(labels = scales::label_comma()) #+
  #scale_y_continuous(labels = scales::dollar_format(prefix="$")) 











