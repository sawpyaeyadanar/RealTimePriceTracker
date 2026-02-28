import Foundation

enum StockSeeds {
    static func seed25() -> [Stock] {
        let items: [(String, String)] = [
            ("AAPL","Apple Inc. designs, manufactures, and markets smartphones, personal computers, tablets, wearables, and accessories worldwide. The company is known for its innovative products including the iPhone, iPad, Mac, Apple Watch, and AirPods."),
            ("GOOGL","Alphabet Inc. is a holding company that provides products and services through its subsidiaries including Google. The company operates through Google Services, Google Cloud, and Other Bets segments, offering search, advertising, cloud computing, and various other technology services."),
            ("MSFT","Microsoft Corporation develops, licenses, and supports software, services, devices, and solutions worldwide. The company offers the Windows operating system, Microsoft Office productivity suite, Azure cloud platform, and various enterprise and gaming solutions."),
            ("TSLA","Tesla, Inc. designs, develops, manufactures, and sells electric vehicles and energy generation and storage systems. The company is a leader in sustainable energy solutions, offering electric cars, solar panels, and battery products."),
            ("AMZN","Amazon.com, Inc. is a multinational technology company focusing on e-commerce, cloud computing, digital streaming, and artificial intelligence. It operates through three segments: North America, International, and Amazon Web Services (AWS)."),
            ("NVDA","NVIDIA Corporation provides graphics, computing and networking solutions worldwide. The company is a leader in GPU technology and artificial intelligence computing, serving gaming, professional visualization, data center, and automotive markets."),
            ("META","Meta Platforms, Inc. builds technologies that help people connect, find communities, and grow businesses. The company operates Facebook, Instagram, WhatsApp, and Messenger, and is developing virtual and augmented reality technologies."),
            ("NFLX","Netflix, Inc. is a streaming entertainment service company offering TV series, documentaries, feature films, and games across various genres and languages. Members can play, pause and resume watching as much as they want, anytime, anywhere."),
            ("GOOG","Alphabet Inc. Class C shares represent non-voting stock in the parent company of Google. The company provides online advertising technologies, search, cloud computing, software, and hardware products and services globally."),
            ("BABA","Alibaba Group Holding Limited provides technology infrastructure and marketing reach to help merchants, brands, retailers and businesses transform the way they do business. The company operates diverse businesses including e-commerce, cloud computing, and digital entertainment."),
            ("TSM","Taiwan Semiconductor Manufacturing Company Limited manufactures and sells integrated circuits and semiconductors. It is the world's largest dedicated independent semiconductor foundry, producing chips for various applications including smartphones, computers, and automotive systems."),
            ("V","Visa Inc. operates a global payments technology company that enables electronic payments and value transfer. The company facilitates digital payments between consumers, merchants, financial institutions, and government entities across more than 200 countries."),
            ("WMT","Walmart Inc. is a multinational retail corporation that operates hypermarkets, discount department stores, and grocery stores. The company is the world's largest retailer, offering a wide variety of merchandise and services at everyday low prices."),
            ("JPM","JPMorgan Chase & Co. is a financial services firm operating worldwide. The company provides investment banking, financial services for consumers and small businesses, commercial banking, financial transaction processing, and asset management."),
            ("JNJ","Johnson & Johnson is a global healthcare company that researches, develops, manufactures, and sells various products in the healthcare field. The company operates through three segments: Consumer Health, Pharmaceutical, and MedTech."),
            ("UNH","UnitedHealth Group Incorporated operates as a diversified health care company in the United States. The company offers health care coverage, software, and data consultancy services through UnitedHealthcare and Optum brands."),
            ("PG","The Procter & Gamble Company provides branded consumer packaged goods to consumers worldwide. The company operates through five segments: Beauty; Grooming; Health Care; Fabric & Home Care; and Baby, Feminine & Family Care."),
            ("MA","Mastercard Incorporated operates as a technology company in the payments industry worldwide. The company facilitates electronic payments and provides transaction processing and related products and services globally."),
            ("DIS","The Walt Disney Company is a diversified worldwide entertainment company operating through Media Networks, Parks & Resorts, Studio Entertainment, and Direct-to-Consumer & International segments. It creates and distributes content across multiple platforms globally."),
            ("PYPL","PayPal Holdings, Inc. operates a technology platform that enables digital payments on behalf of merchants and consumers worldwide. The company provides payment solutions including PayPal, PayPal Credit, Venmo, and other payment processing services."),
            ("BAC","Bank of America Corporation provides banking and financial products and services for individual consumers, small and middle-market businesses, institutional investors, large corporations, and governments worldwide through its various segments."),
            ("INTC","Intel Corporation designs, manufactures, and sells computing and communications components worldwide. The company operates through multiple segments including Client Computing, Data Center, Internet of Things, and other technology solutions."),
            ("ADBE","Adobe Inc. provides creative, marketing, and document management solutions worldwide. The company is known for products including Photoshop, Illustrator, Premiere Pro, Acrobat, and various cloud-based creative and marketing services."),
            ("CRM","Salesforce, Inc. provides customer relationship management technology that brings companies and customers together. The company's platforms include Sales Cloud, Service Cloud, Marketing Cloud, Commerce Cloud, and various enterprise solutions."),
            ("NKE","NIKE, Inc. designs, develops, markets, and sells athletic footwear, apparel, equipment, accessories, and services worldwide. The company is a leader in the athletic footwear and apparel industry, known for its innovative products and brand marketing.")
        ]

        return items.map {
            let price = Double.random(in: 50...500)
            return Stock(
                symbol: $0.0,
                description: $0.1,
                price: price,
                previousPrice: price - Double.random(in: -10...10)
            )
        }
    }
}
