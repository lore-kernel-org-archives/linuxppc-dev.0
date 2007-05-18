Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 59034DDEBD
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 04:03:02 +1000 (EST)
Message-ID: <464DEA4F.4030609@freescale.com>
Date: Fri, 18 May 2007 13:02:55 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev
	1.02hardware
References: <1179245829.8132.100.camel@rhino>
	<1179247809.8132.138.camel@rhino>	<46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>	<1179417813.8132.250.camel@rhino>	<744CD970-5421-47D6-A30A-C7C79BE21BE8@kernel.crashing.org>	<1179421139.8132.256.camel@rhino>
	<464CA302.9060707@freescale.com>	<20070518005641.GA27350@localhost.localdomain>	<464DB986.20205@freescale.com>
	<20070518164628.GA16825@ld0162-tx32.am.freescale.net>
	<464DE2D3.3090805@smiths-aerospace.com>
	<464DE4C7.7030906@freescale.com> <464DE5D2.5000301@freescale.com>
	<464DE6C1.2010108@freescale.com> <464DE7F7.3030302@freescale.com>
	<464DE8BB.5040601@freescale.com>
In-Reply-To: <464DE8BB.5040601@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
>> That's your model.  

Yes.  That was the whole point of my post, to point out my alternative. 
    You were the one that said, "Actually, we're talking about the same 
thing."

>> Mine involves merging a fragment that corresponds 
>> to an active hwoption, with no complex conditional evaluation or 
>> deletion of anything from the main tree.
> 
> 
> I think my model (which is also Jon's, I think) is easier to read 

What does the dtb-level implementation have to do with ease of reading? 
  I said that I didn't mind conditionals at the source level that get 
turned to hwoptions at the dtb level.

> and implement.

I disagree.

> phy-node [ if j22 = on ]
> {
>     phy-type = 1
> }
> 
> phy-node [ if j22 = off ]
> {
>     phy-type = 2
> }

Ah.

So I take it you'll need a new dtb version to implement this?  No such 
revision would be needed for my model.

-Scott
