#### Teaching R for MBIO 710
### First, automator service for copying paths
## https://www.cnet.com/how-to/how-to-copy-a-file-path-in-os-x/
getwd()
setwd()

print('Hello World')

1 + 2

#### Automator

#### Objects

  a = 'Hello World'
  print(a)
  
  a = 1
  b = 2
  a + b
  ## Note c is the concatinate function, so don't assign.
  d
  d = a + b
  
  ## Concatinating variables
  e = c(1,4,5)
  g = e + b
  
  e > a # Also can use >=
  e >= a
  e < a # Also can use <=
  e <= a
  e == a
  
  h = TRUE
  i = TRUE
  j = FALSE
  
  h & i
  h_and_i = h & i
  h_and_j =  h & j
  h_or_i = h | i
  h_or_j = h | j
  
  
#### Classes
  class(a)
  class(h_and_i)
  class('Hello World')
  
#### Typing in a small data set
  #### Three Fish recaptured each once
  fdata = data.frame('Year' = c(2012, 2013, 2009),
                          'Station' = c('A1006', 'A1008', 'A1009'),
                          'Lat' = c(18.82, 19.76, 20.23),
                          'Long' = c(-159.72, -158.96, -158.58),
                          'JanLength' = c(44.3, 36.8, 36.5),
                          'MayLength' = c(48.4, 44.9, 53.4),
                          'OctLength' = c(65, 100.2, 74),
                          'JanWeight' = c(0.07018, 0.06523, 0.065075),
                          'MayWeight' = c(0.07264, 0.07054, 0.07548),
                          'OctWeight' = c(0.08149, 0.09648, 0.08572))
  fdata
  View(fdata)
  #### Add fourth fish with captured in year 2011, at station A1009, Lat = 20.23, Lon =	-158.58, 
      ## JanLength = 38.1,	May Length = 48.2,	October Length = 79.3,	
      ## Jan Weight = 0.066172985, May Weight =	0.072528439, October Weight = 0.08807173
  
  ## 1. By Hand
  ## 2. using data.frame() and rbind()
  new_data_frame = data.frame('Year' = 2011,  'Station' = 'A1009', 'Lat' = 20.23, 'Long' =	-158.58, 'JanLength' = 38.1,	'MayLength' = 48.2,	'OctLength' = 79.3,	'JanWeight' = 0.066172985, 'MayWeight' = 0.072528439, 'OctWeight' = 0.08807173)
  rbind(fdata, new_data_frame)
  fdata = rbind(fdata, new_data_frame)
  
  #### Loading in Full Data Set
  fdata = read.csv('/Users/stephenscherrer/Dropbox/School Stuff/17-18/Fall 2017/MBio 710 - Methods in Tagging and Mark Recapture/data/FishLengthSubsetFunctionChained copy.csv')
  dim(fdata)
  View()
  
  #### Subsetting Data - station A1009
  ## Matrix Notation [i,j], 3rd fish, length in october
  fdata[3, 7]
  fdata[3, 'OctLength']
  fdata$OctLength[3]
  
  ## All the rows where "Station" is 'A1009'
  station_A1009 = fdata[fdata$Station == 'A1009', ]
  
  #### Sorting Data - by JanLength
  sort(fdata$JanLength)
  order(fdata$JanLength)
  fdata = fdata[order(fdata$JanLength), ]
  
  #### Calculating summary statistics
  ## Mean, Median, std deviation - Jan Length
    mean(fdata$JanLength)
    median(fdata$JanLength)
    sd(fdata$JanLength)
    fivenum(fdata$JanLength) # Min, 1st Quantile, Median, 3rd Quantile, Max
    
  #### Creating a new variable
    ## Growth between January and May
      JanMayGrowth = fdata$MayLength - fdata$JanLength 
      
      ## Adding to existing dataframe using cbind
      fdata = cbind(fdata, JanMayGrowth)
      
      ## Adding using $ opperator
      ## Growth Between May and October

      fdata$MayOctGrowth = abs(fdata$OctLength - fdata$MayLength)
      

  
  #### Create a new delta_time variable - diff between January and May
      JanYear = paste(fdata$Year, "-01-01", sep = "")
      ?as.POSIXct()
      JanYear = as.POSIXct(JanYear)
      fdata$JanYear = JanYear
      MayYear = as.POSIXct(paste(fdata$Year, "05-01", sep = "-"))
      ?difftime()
      fdata$dtJanMay = difftime(JanYear, MayYear)
      
  #### Plotting 
  # IS there a relationship between year and growth rate?
    plot(fdata$JanMayGrowth ~ fdata$Year)
    mean_growth_by_year = aggregate(fdata$JanMayGrowth, by = list(fdata$Year), FUN = mean)
      colnames(mean_growth_by_year) = c('year', 'dl')
    lines(mean_growth_by_year$dl ~ mean_growth_by_year$year, type = 'l')
    
    ## Change axis and axis labels
      plot(fdata$JanMayGrowth ~ fdata$Year, 
           xlim = c(min(fdata$Year), max(fdata$Year)), xlab = 'year', 
           ylim = c(0, 30), ylab = 'dl')
  
      ### Linear Model - Length ~ Time
      growth_lm = lm(fdata$JanMayGrowth ~ fdata$Year)
      summary(growth_lm)
      plot(growth_lm)
  
  
      #### Loops
  # Loop through stations to plot
  for(station in fdata$Station){
    subset_data = fdata$Station[fdata$Station == station, ]
    lines()
  }
  
  ## Adding a counter - plot in a different color
  plot_colors = c('red', 'blue', 'green')
  counter = 1
  for(station in fdata$Station){
    subset_data = fdata$Station[fdata$Station == station, ]
    lines(, col = plot_color[counter])
    counter = counter + 1
  }
  #### Exporting Data
  # read.csv()
  
  #### Writing Functions
    ##  first take mean, then divide by standard deviation
  
  
  #### Dates and Times - The Bane of programming
  ## as.POSIXct()
  ## Using help files
  ## Stack overflow
  
  
  #### Resources
  ### Google!
  ### Stack Overflow - https://stackoverflow.com/documentation/r/topics
  ### Adv.R Style Guide - http://adv-r.had.co.nz/Style.html
  ### Google's Style Guide - https://google.github.io/styleguide/Rguide.xml#identifiers