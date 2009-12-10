Return-Path: <mware@elphinstone.net>
Received: from ipmail02.adl6.internode.on.net (ipmail02.adl6.internode.on.net
	[203.16.214.140]) by ozlabs.org (Postfix) with ESMTP id E5EA6B6EF5
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2009 22:10:17 +1100 (EST)
Message-ID: <4B20D718.9050204@elphinstone.net>
Date: Thu, 10 Dec 2009 22:10:16 +1100
From: Mark Ware <mware@elphinstone.net>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] cpm2_pic: Allow correct flow_types for port C
	interrupts
References: <4B1EF3E9.8050005@elphinstone.net>
	<20091209215334.GA536@oksana.dev.rtsoft.ru>
	<4B201D67.4070802@freescale.com>
In-Reply-To: <4B201D67.4070802@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Anton Vorontsov wrote:
>>> +        if ((flow_type != IRQ_TYPE_EDGE_BOTH) && +           
>>> (flow_type != IRQ_TYPE_EDGE_FALLING)) {
>>
>> I'd place one more tab here.
> 
> Or better, align one "flow_type" with the other.
> 
> -Scott
> 

Thanks Anton and Scott.

Scott's suggestion is also my preferred style, but a (brief) search through the source didn't reveal much support.

I'll send a new version shortly including you suggestions.

- Mark
