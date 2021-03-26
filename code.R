activewear=read.csv('activewear/activewear.csv')
activewear$price=as.numeric(gsub("\\$", "", activewear$price))
library(stringr)
library(dplyr)
activewear$gender= word(activewear$category,1)
activewear$Category= word(activewear$category,2)
activewear$Category= gsub('Activewear','Short Sleeve Shirts', activewear$Category)
activewear$brand=word(activewear$brand,1)
activewear$brand=gsub('adidas','Adidas',activewear$brand)
activewear$brand=gsub('Under', 'Under Armour',activewear$brand)
activewear=activewear%>%filter(price<800, activewear$brand!='Under Armour')

ggplot(data=activewear%>%filter(brand=='Nike',Category=="Sneakers"))+geom_boxplot(aes(x=gender,y=price,color=gender))+xlab('Gender')+ylab('Price')+ggtitle('Nike Sneakers')+
  scale_color_manual(values = c("Men" = "blue2","Women" = "deeppink2"))+theme_bw()+
  theme(plot.title = element_text(hjust = 0.5))
ggplot(data=activewear%>%filter(brand=='Nike',Category=="Shorts"))+geom_boxplot(aes(x=gender,y=price,color=gender))+xlab('Gender')+ylab('Price')+ggtitle('Nike Shorts')+
  scale_color_manual(values = c("Men" = "blue2","Women" = "deeppink2"))+theme_bw()+
  theme(plot.title = element_text(hjust = 0.5))
ggplot(data=activewear%>%filter(brand=='Nike',Category=="Short Sleeve Shirts"))+geom_boxplot(aes(x=gender,y=price,color=gender))+xlab('Gender')+ylab('Price')+ggtitle('Nike Short Sleeve Shirts')+
  scale_color_manual(values = c("Men" = "blue2","Women" = "deeppink2"))+theme_bw()+
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data=activewear%>%filter(brand=='Adidas',Category=="Sneakers"))+geom_boxplot(aes(x=gender,y=price,color=gender))+xlab('Gender')+ylab('Price')+ggtitle('Adidas Sneakers')+
  scale_color_manual(values = c("Men" = "blue2","Women" = "deeppink2"))+theme_bw()+
  theme(plot.title = element_text(hjust = 0.5))
ggplot(data=activewear%>%filter(brand=='Adidas',Category=="Shorts"))+geom_boxplot(aes(x=gender,y=price,color=gender))+xlab('Gender')+ylab('Price')+ggtitle('Adidas Shorts')+
  scale_color_manual(values = c("Men" = "blue2","Women" = "deeppink2"))+theme_bw()+
  theme(plot.title = element_text(hjust = 0.5))
ggplot(data=activewear%>%filter(brand=='Adidas',Category=="Short Sleeve Shirts"))+geom_boxplot(aes(x=gender,y=price,color=gender))+xlab('Gender')+ylab('Price')+ggtitle('Adidas Short Sleeve Shirts')+
  scale_color_manual(values = c("Men" = "blue2","Women" = "deeppink2"))+theme_bw()+
  theme(plot.title = element_text(hjust = 0.5))

meanbybrandcategorygender= activewear%>%group_by(Category, brand, gender)%>%summarise(ave=mean(price))

meanbycategorygender=activewear%>%group_by(Category,gender)%>%summarise(ave=mean(price))


ratiodiff=data.frame(ratdiff=((data.frame(meanbybrandcategorygender%>%filter(gender=='Men'))$ave)/(data.frame(meanbybrandcategorygender%>%filter(gender=='Women'))$ave)))

men=meanbybrandcategorygender%>%filter(gender=='Men')
ratio= data.frame(RatioDifferenceFromWomen=ratiodiff$ratdiff, BrandAndCategory= c('Adidas Short Sleeve Shirts','Nike Short Sleeve Shirts','Adidas Shorts','Nike Shorts','Adidas Sneakers','Nike Sneakers'), Brand=c('Adidas','Nike','Adidas','Nike','Adidas','Nike'))


meanbybrandcategorygender$name= paste(meanbybrandcategorygender$brand,meanbybrandcategorygender$Category)

#ggplot(data=meanbybrandcategorygender)+geom_bar(aes(x=name,y=ave,fill=gender),position='dodge', stat='identity')+scale_fill_manual(values = c("Men" = "blue2","Women" = "deeppink2"))+coord_flip()

ggplot(data=ratio%>%filter(Brand=='Nike'))+geom_bar(aes(x=BrandAndCategory, y=RatioDifferenceFromWomen),stat='identity',fill = rainbow(n=3))+theme_bw()+coord_flip()+geom_hline(aes(yintercept=1))+ylab('Ratio of Average Price: Men to Women')+xlab('Nike Category')
ggplot(data=ratio%>%filter(Brand=='Adidas'))+geom_bar(aes(x=BrandAndCategory, y=RatioDifferenceFromWomen),stat='identity',fill = rainbow(n=3))+theme_bw()+coord_flip()+geom_hline(aes(yintercept=1))+ylab('Ratio of Average Price: Men to Women')+xlab('Adidas Category')

countpergroup=data.frame(activewear%>%group_by(Category, brand, gender)%>%summarise(count=n()))
countpergroup$group=paste(countpergroup$brand, countpergroup$Category)
ggplot(data=countpergroup%>%filter(brand=='Nike'))+geom_bar(aes(x=group,y=count,fill=gender),position='dodge', stat='identity')+scale_fill_manual(values = c("Men" = "blue2","Women" = "deeppink2"))+theme_bw()+theme(axis.text.x = element_text(angle = 10,size=8))+xlab('Category')+ylab('Count')
ggplot(data=countpergroup%>%filter(brand=='Adidas'))+geom_bar(aes(x=group,y=count,fill=gender),position='dodge', stat='identity')+scale_fill_manual(values = c("Men" = "blue2","Women" = "deeppink2"))+theme_bw()+theme(axis.text.x = element_text(angle = 10,size=8))+xlab('Category')+ylab('Count')

