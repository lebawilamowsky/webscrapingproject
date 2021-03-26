from activewear.items import ActivewearItem
from scrapy import Spider, Request

class ActivewearSpider(Spider):
	name= 'activewear_spider'
	allowed_urls = ['https://www.zappos.com/']
	start_urls = ['https://www.zappos.com/filters/women-sneakers-athletic-shoes/CK_XARC81wFaDG-7GtMSAYMPzRnhBsABAeICBAECCxg.zso',
	'https://www.zappos.com/filters/men-sneakers-athletic-shoes/CK_XARC81wFaDG-7GtMSAYMPzRnhBsABAuICBAECCxg.zso',
	'https://www.zappos.com/filters/women-activewear-shirts/CKvXARDL1wEY6e0BOgSfDfEDWgpvuxrTEpEcAYMPwAEB4gIHAQIDCxgHBw.zso',
	'https://www.zappos.com/filters/men-activewear-shirts/CKvXARDL1wEY6e0BOgSfDfEDWgpvuxrTEpEcAYMPwAEC4gIHAQIDCxgHBw.zso',
	'https://www.zappos.com/filters/women-shorts/CKvXARDM1wE6Ap8NWgpvuxrTEpEcAYMPwAEB4gIFAQILGAc.zso',
	'https://www.zappos.com/filters/men-shorts/CKvXARDM1wE6Ap8NWgpvuxrTEpEcAYMPwAEC4gIFAQILGAc.zso']

	def parse (self, response):
		try:
			num_pages = int(response.xpath('//div[@class="at-z"]/text()').extract_first().split(' ')[2])
		except:
			try:
				num_pages = int(response.xpath('//div[@class="RG-z"]/text()').extract_first().split(' ')[2])
			except:
				num_pages = int(response.xpath('//span[@class="Mr-z"]/a[last()]/text()').extract_first())
		
		result_urls = [response.url + f'?p={i}' for i in range(num_pages)]
		
		category = response.xpath('//div/h1/text()').extract_first()

		for url in result_urls:
			yield Request(url=url, callback=self.parse_results_page, meta={'category':category})

	def parse_results_page(self, response):
	
		
		products= response.xpath('//article')
		for product in products:
			try:
				price = product.xpath('.//dd[@itemprop="offers"]/span[2]/text()').extract()[1]
			except:
				price = product.xpath('.//dd[@itemprop="offers"]/span[1]/text()').extract_first()
			brand= product.xpath('.//dd[@itemprop="brand"]/text()').extract_first()
			item=ActivewearItem()
			item['category']=response.meta['category']
			item['brand']=brand
			item['price']=price
			yield item
