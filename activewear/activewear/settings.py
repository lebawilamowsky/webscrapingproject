
DOWNLOAD_DELAY= 2

ROBOTSTXT_OBEY= False

USER_AGENT= "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.2 Safari/605.1.15"

BOT_NAME = 'activewear'

SPIDER_MODULES = ['activewear.spiders']
NEWSPIDER_MODULES = 'activewear.spiders'

ITEM_PIPELINES= {
	'activewear.pipelines.WriteItemPipeline': 300
}