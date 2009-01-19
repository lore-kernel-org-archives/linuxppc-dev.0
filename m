Return-Path: <paulius.zaleckas@teltonika.lt>
Received: from teltonika.lt (81-7-68-229.static.zebra.lt [81.7.68.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D59D9DDED3
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 19:56:54 +1100 (EST)
Message-ID: <49743EBD.6070500@teltonika.lt>
Date: Mon, 19 Jan 2009 10:50:05 +0200
From: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Documentation: fix mdio-gpio name in
	booting-without-of.txt
References: <20081117143238.8214.68389.stgit@Programuotojas.82-135-208-232.ip.zebra.lt>
	<1231285232.14860.33.camel@pasglop>
In-Reply-To: <1231285232.14860.33.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Mon, 2008-11-17 at 16:32 +0200, Paulius Zaleckas wrote:
>> Signed-off-by: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
>> ---
>>
>>  Documentation/powerpc/booting-without-of.txt |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>>
>> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
>> index 0ab0230..8670acc 100644
>> --- a/Documentation/powerpc/booting-without-of.txt
>> +++ b/Documentation/powerpc/booting-without-of.txt
>> @@ -1822,7 +1822,7 @@ platforms are moved over to use the flattened-device-tree model.
>>     g) MDIO on GPIOs
>>  
>>     Currently defined compatibles:
>> -   - virtual,gpio-mdio
>> +   - virtual,mdio-gpio
> 
> Except that the only occurence in the code seems to have it the 
> other way round ...

Where? The driver defines it as "virtual,mdio-gpio"
See drivers/net/phy/mdio-gpio.c:235
