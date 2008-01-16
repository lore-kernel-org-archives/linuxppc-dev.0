Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 17741DDEED
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 10:51:08 +1100 (EST)
Message-ID: <478E986A.1090405@pikatech.com>
Date: Wed, 16 Jan 2008 18:51:06 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] MTD for Taco
References: <477F12D1.2070109@pikatech.com><200801051041.18173.sr@denx.de><478AEB39.70106@pikatech.com><478E7643.5040804@pikatech.com>
	<20080116173421.4c886514@zod.rchland.ibm.com>
In-Reply-To: <20080116173421.4c886514@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Wed, 16 Jan 2008 16:25:23 -0500
> Sean MacLennan <smaclennan@pikatech.com> wrote:
>
>   
>> Sean MacLennan wrote:
>>     
>>> How about adding a config option that lets you specify 8 bit access? 
>>> Something like CONFIG_NDFC_8BIT_ACCESS. We could default it to no and 
>>> put a little blurb that says something like:
>>>
>>> On some platforms the 32bit read/writes cause a machine access 
>>> exception. If you get a machine access exception while reading the NAND 
>>> bad block table, try turning on 8 bit access.
>>>   
>>>       
>> I know it would be better if 32 bit access just worked, but nobody 
>> actively objected to this idea, so here is a patch ;)
>>     
>
> I'm objecting, but not on the bit access reasons :).
>
> 1) Needs to go to the linux-mtd@lists.infradead.org list with the
> maintainer CC'd (Thomas Gleixner)
>   
Ok.
> 2) I don't want this driver enabled in mainline for boards in
> arch/powerpc until it fully understands how to parse device trees.
>   
Fair enough. I thought it would be better to have a driver that compiles 
and is usable for arch/powerpc, even if not quite correct. We (PIKA) are 
going to be using a NAND flash, so we need the ndfc driver working. But 
I can understand wanting it "right" before you put it in the kernel.

Cheers,
   Sean
