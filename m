Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DE5E3DDEBF
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 06:52:27 +1000 (EST)
Message-ID: <47225327.2070103@freescale.com>
Date: Fri, 26 Oct 2007 15:50:47 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: reg adjust_total_lowmem
References: <4dd2a2ce0710252051pe83a943q48f52d148f5a9603@mail.gmail.com>	<524E69ED-899B-452F-B593-44499C5181A3@kernel.crashing.org>
	<20071026194005.GA4571@loki.buserror.net>
In-Reply-To: <20071026194005.GA4571@loki.buserror.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Surya Ravikiran <koduks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On Fri, Oct 26, 2007 at 10:04:19AM -0500, Kumar Gala wrote:
>> The reason you have 192M is that lowmem is the total amount of memory  
>> that can be covered by up to three CAM entries.  In the case of  
>> setting mem=252M that max that three CAM entries can cover is 192M (64 
>> +64+64).  You should be able to access the other 60M via HIGHMEM.
> 
> Why doesn't it just use a 256M mapping, and not access the last 4M?

Not to mention, why highmem and not just normal TLB0 mappings for the 
extra pages?

-Scott
