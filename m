Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id DDD34DDE0D
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jan 2008 14:21:00 +1100 (EST)
Message-ID: <4780491A.8080006@pikatech.com>
Date: Sat, 05 Jan 2008 22:20:58 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org,
	david@gibson.dropbear.id.au
Subject: Re: [PATCH] MTD for Taco
References: <477F12D1.2070109@pikatech.com> <200801051041.18173.sr@denx.de>
	<20080105122542.GH4326@localhost.localdomain>
In-Reply-To: <20080105122542.GH4326@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
>> I'm pretty sure that you don't need a board specific mapping driver
>> for NOR flash. physmap_of should be exactly what you need. You just need
>> to fill the device tree properties correctly.
>>     
>
> Absolutely.  We should not be using C-coded maps in arch/powerpc
>
>   

Ok a couple of questions. How do I find out the size of the NOR flash? 
It was in a global in the ppc arch.

Also, where is the best place to fixup the partitions? We have paritions 
that must be at the top and ones that must be at the bottom, so we 
dynamically setup the partitions based on the NOR size. The NOR size is 
variable.

And is it ok the name the paritions in the dts based on an index? I 
notice others use an address, but since I don't know the address up 
front I just used index numbers.

Cheers,
   Sean
