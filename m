Return-Path: <Becky.Bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 2D91467BBE
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 02:02:16 +1000 (EST)
In-Reply-To: <453E34FB.3030209@genesi-usa.com>
References: <453771E5.4090808@bplan-gmbh.de>	<77AD49CA-69CB-4ADA-B8F3-3BC3A066BCF9@kernel.crashing.org>	<453884F5.4000804@bplan-gmbh.de>	<122A4E06-B8A6-4256-B96E-3811EA93EA25@kernel.crashing.org>	<453B6A84.3050209@bplan-gmbh.de>	<1161585371.10524.444.camel@localhost.localdomain>	<453CD615.4050401@genesi-usa.com>
	<17725.18623.768768.438157@cargo.ozlabs.ibm.com>
	<453E34FB.3030209@genesi-usa.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <324B0B81-6917-4CEF-B16A-E569B0727EB4@freescale.com>
From: Becky Bruce <Becky.Bruce@freescale.com>
Subject: Re: [PATCH] General CHRP/MPC5K2 Platform and drivers support - to
	comment
Date: Tue, 24 Oct 2006 11:01:56 -0500
To: Matt Sealey <matt@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 24, 2006, at 10:44 AM, Matt Sealey wrote:

>
> Paul Mackerras wrote:
>> Matt Sealey writes:
>>
>> "PowerPC" is the name of the instruction set architecture, "POWER" is
>> the name of some specific implementations of the PowerPC architecture
>> made by a certain large multinational computer company.  Unless  
>> you're
>> talking about the really really old ISA that was the predecessor of
>> PowerPC, that is. :)
>
> http://www.power.org/news/articles/new_brand/#isa
>
> I'm talking about the one they consolidated from all the different  
> specs
> Freescale, AMCC and IBM had about what makes a PowerPC processor.  
> Since
> POWER is part of it and it's all Power.org now.. they seem to have  
> changed
> the name.
>
> I don't think they have actually added anything new, that wasn't there
> before, just consolidated it. You won't seen an IBM chip with SPE  
> or VLE
> unless they license the gaggle of patents Freescale have on those
> units, maybe.. but there is always a possibility. All new chips are
> being called Power (not POWER).
>

The ISA version 2.03 that you are talking about does, in fact, rename  
it to "Power ISA" (big "P" little "ower") from "PowerPC ISA".  This  
spec is mostly a big glom of all of FSL and IBM's architecure  
documentation, although there were some minor changes made and some  
things were added.  If you read the spec carefully (which, btw, I do  
*not* recommend, as it is about 900 pages of spaghetti  
documentation), you will find things in there that do not exist in  
any implemented processor to date.

Cheers,
B
