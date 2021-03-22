
import scrapy


class ActivewearItem(scrapy.Item):
	category=scrapy.Field()
	brand=scrapy.Field()
	price=scrapy.Field()
