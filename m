Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C683ADDE1A
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 01:24:02 +1100 (EST)
Message-ID: <47DFD004.4000202@ru.mvista.com>
Date: Tue, 18 Mar 2008 17:21:56 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH] net: NEWEMAC: Support for Pause packets in EMAC driver
References: <1205488348-22536-1-git-send-email-sr@denx.de>	
	<47DE5F43.80604@garzik.org> <1205789101.26869.181.camel@pasglop>	
	<1205789205.26869.184.camel@pasglop>	
	<20080317164341.12075616@zod.rchland.ibm.com>	
	<1205790747.26869.187.camel@pasglop> <47DEF159.3020504@garzik.org>	
	<20080317200855.2954971a@zod.rchland.ibm.com>
	<1205808100.26869.204.camel@pasglop>
In-Reply-To: <1205808100.26869.204.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: netdev@vger.kernel.org, Stefan Roese <sr@denx.de>,
	Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> http://marc.info/?l=linux-netdev&m=120449748701492&w=2
>>
>> I sent it to Ben with netdev on CC because you asked the various people
>> sending NEWEMAC patches to you to find a single person.
>>
>> So from now on, what are we going to do?  It seems we're playing net
>> maintainer russian roulette for NEWEMAC and it's getting old.
> 
> I'm happy to collect the patches. I said I would do it, I was just taken
> aback a bit by Jeff suddenly merging two of Stefan patches directly :-)
> 
> I was actually planning this week to post a serie of all the pending
> EMAC patches for final review.
> 
> Cheers,
> Ben.
> 
> 

FYI, These are the NEWEMAC patches I've sent:
http://ozlabs.org/pipermail/linuxppc-dev/2008-February/052114.html
(This is a TAH csum fix, that I don't see on the patchwork for some reason)
and a couple of PHY clock workarounds
http://patchwork.ozlabs.org/linuxppc/patch?id=17211
http://patchwork.ozlabs.org/linuxppc/patch?id=17212
The latter two patches depend on the "dcri_clrset" one:
http://patchwork.ozlabs.org/linuxppc/patch?id=17199
Ben, could you please also take a look at the PCIe dcri_clrset stuff here
http://patchwork.ozlabs.org/linuxppc/patch?id=17214
(not EMAC related)
Thanks,
Valentine.
