from Model.countryStatistics import countryStatistics
from Model.userCountryStatistics import userCountryStatistics
from Controller.countryStatisticsController import countryStatisticsController
from Service.ipDatabase import geoipDatabase
from Logger import log
import ipaddress

class ipToCountry:
  logger = log.get_logger("ipToCountry")

  @classmethod
  def mapIpToCountry(self):
    # handler for ip databases
    ipDatabaseHandler = geoipDatabase()
    ipData = countryStatisticsController.getDataNotMapped()
    countryStatsList = []
    usercountryStatsList = []
    mappedItems = 0 
    for item in ipData:
      # get network address
      ipaddr = ipaddress.ip_network(item.ip).network_address
      # get country code/ name
      countryData = ipDatabaseHandler.getCountryFromIp(str(ipaddr), item.ipVersion)
      if(countryData[0] != None):
        mappedItems +=1
      else:
        countryData[0] = 'UN'
        countryData[1] = 'Unknown'
        self.logger.warning("ip {0} not found at database".format(ipaddr))

      countryStatisticsItem = countryStatistics(None, item.accessed, item.sourceIdp, item.service, countryData[0], countryData[1], 1)
      countryStatsList.append(countryStatisticsItem)
      usercountryStatisticsItem = userCountryStatistics(None, item.accessed, item.userid, countryData[0], countryData[1], 1)
      usercountryStatsList.append(usercountryStatisticsItem)
    
    # save data to tables if any
    if countryStatsList:
      countryStatistics.saveAll(countryStatsList)
      userCountryStatistics.saveAll(usercountryStatsList)
      self.logger.info("{0} ips mapped to countries".format(mappedItems))
    else:
      self.logger.info("No new data found")
      

#run script      
ipToCountry.mapIpToCountry()
    
