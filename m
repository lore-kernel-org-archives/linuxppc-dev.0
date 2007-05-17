Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5C0F2DDEBB
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 04:46:46 +1000 (EST)
Message-ID: <464CA302.9060707@freescale.com>
Date: Thu, 17 May 2007 13:46:26 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Wade Farnsworth <wfarnsworth@mvista.com>
Subject: Re: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev
	1.02hardware
References: <1179245829.8132.100.camel@rhino>
	<1179247809.8132.138.camel@rhino>	<46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>	<1179417813.8132.250.camel@rhino>	<744CD970-5421-47D6-A30A-C7C79BE21BE8@kernel.crashing.org>
	<1179421139.8132.256.camel@rhino>
In-Reply-To: <1179421139.8132.256.camel@rhino>
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

Wade Farnsworth wrote:

> Yes.  On rev 1.0 boards, all of the devices on the south bridge are on
> bus 0, while on rev 1.02, the devices on the southbridge are on bus 2.
> 
> I'd like to use the same dts for both rev's if possible.  But if there
> is a reason why they shouldn't, I suppose I could create a separate dts.

I think two DTS files is the best approach for now.  A few of us had an idea to introduce 
conditional statements in to the DTS, and U-Boot would examine the board and/or 
environment variables and then apply the conditions to the device tree before booting the 
kernel.  This would allow you to merge the two DTS files into one, but we're quite a ways 
off from implementing this feature.  In the meantime, two DTS files is okay.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
