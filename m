Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id E49D9DDDF7
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 05:17:06 +1000 (EST)
Message-ID: <464CAA2B.1020105@smiths-aerospace.com>
Date: Thu, 17 May 2007 15:16:59 -0400
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev
	1.02hardware
References: <1179245829.8132.100.camel@rhino>	<1179247809.8132.138.camel@rhino>	<46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>	<1179417813.8132.250.camel@rhino>	<744CD970-5421-47D6-A30A-C7C79BE21BE8@kernel.crashing.org>	<1179421139.8132.256.camel@rhino>	<464CA302.9060707@freescale.com>
	<464CA380.2020705@freescale.com>	<464CA4B4.7070202@freescale.com>
	<464CA610.1050504@freescale.com>
In-Reply-To: <464CA610.1050504@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Scott Wood wrote:
> 
>> We also don't want people using a perfectly good device tree on a newer 
>> revision of the board that just fixes things and doesn't make any 
>> device-tree-relevant changes,
> 
> Well, either one device tree is okay, or we need two.  If we do need two, then it would be 
> bad to load the wrong one on a particular board and have only 90% functionality.  If he 
> have the ability to prevent customers from getting confused, then we should do that.  I 
> wish this was standard behavior for all device trees.  I've frequently loaded the wrong 
> device tree and wondered why nothing worked.

Wolfgang Grandegger and Detlev Zundel are working on using fdts for 
configuring u-boot itself (I'm only indirectly involved: I am custodian 
for u-boot-fdt).

I envision the likely progression of this and other activities will be 
to make fdt properties (variables) first class citizens of u-boot: 
substantially and possibly entirely replacing the traditional u-boot 
environment variables.  This would imply that you could write a hush 
script that u-boot executed that would pick the right fdt, or at least 
complain if you had the wrong fdt.

Theoretically.  Some assembly required. :-/

I see Timur just sent an email on the u-boot list proposing a 
"fdt_checkboard()" function.  Hmmm, something to think about...

Best regards,
gvb
