require("readxl")
require("tidyr")
require("dplyr")

referenciados <- read_xlsx("data/Microregion1.xlsx", sheet = "Referenciados")
referenciantes <- read_xlsx("data/Microregion1.xlsx", sheet = "Referencian")

referenciados %>% 
  gather("field","value", 3:101) %>%
  filter(Numero == 151900828 )
      
referenciantes %>%
  gather("field", "value", 4:102) %>%
 filter(Referencia == 151900828 )

all <- merge( referenciados %>% 
                gather("field","value", 3:101),
              referenciantes %>%
                gather("field", "value", 4:102),
              by.x = c("Numero","Microregion","field"),
              by.y = c("Referencia","Microregion","field")
  )

all <- rbind(select(referenciados,c("Numero","Microregion","field","value")),
             referenciantes)