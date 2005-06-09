Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id E8BDE67B28
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 16:36:07 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j596fJEr006179
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 9 Jun 2005 09:41:20 +0300 (EEST)
Message-ID: <42A7DE75.8040205@intracom.gr>
Date: Thu, 09 Jun 2005 09:15:17 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
References: <20050608102938.023f271f.ajz@cambridgebroadband.com>
	<d32482ab845e745a00426671eff86b9e@embeddededge.com>
In-Reply-To: <d32482ab845e745a00426671eff86b9e@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: consistent_alloc() on 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:
> 
> On Jun 8, 2005, at 5:29 AM, Alex Zeffertt wrote:
> 
>> Does anybody know why it isn't built for 6xx cores?
> 
> 
> Because 6xx cores are cache coherent and there shouldn't
> be any need for "uncached" memory regions.
> 
>> I'm working on the ATM driver and it seems that certain external memory
>> areas accessed by the PQII CPM by-pass the cache.
> 
> 
> That's news to me, and I've written lots of CPM drivers, including ATM.
> Do you have a specific example?
> 

I may also need consistent_alloc for some testing reasons Dan. :)

> Thanks.
> 
>     -- Dan
> 

If I build arch/ppc/mm/cachemap.c will it work for 82xx? Any reason not to?

Regards

Pantelis
