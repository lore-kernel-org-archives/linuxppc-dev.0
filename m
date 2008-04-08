Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7CFF3DE069
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 06:07:40 +1000 (EST)
Message-ID: <47FBD09E.80504@freescale.com>
Date: Tue, 08 Apr 2008 15:07:58 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: Question on mpc52xx_common.c
References: <m21w5map5f.fsf@ohwell.denx.de>	<fa686aa40804031200n4cd7aeb4g330ab3e2620680e@mail.gmail.com>	<47FAA0A8.7050602@genesi-usa.com>	<200804080414.42867.arnd@arndb.de>	<fa686aa40804071925v6c7d28edna529e6122fdc9cf7@mail.gmail.com>	<23d2e4300804071926n57746a3cj551ef38bf10486c7@mail.gmail.com>	<47FB3CD6.2090706@genesi-usa.com>	<fa686aa40804080752g595196det8f576df1884bac5d@mail.gmail.com>
	<20080408194517.GX13814@pengutronix.de>
In-Reply-To: <20080408194517.GX13814@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Robert Schwebel wrote:
> Well observed; isn't this the prove of the assumption that the whole
> device tree idea is not working? It is *always* inconsistent and it is
> *maintenance hell* because out-of-tree ports do *always* breakt because
> of string inconsistencies. We have just ported a 8260 board from 2.6.22
> to 2.6.25 and it is almost 100% oftree porting.

There's going to be more churn in the initial stages than down the road. 
  82xx had barely been added to arch/powerpc in 2.6.22, and there was 
little review of the initial device tree bindings.

> The ARM method of using just a device number is so much easier ...

Yeah, it's so much fun to have to allocate a globally unique number for 
every minor tweak of a board, and to have to maintain a mapping from 
said numbers to information that is semantically equivalent to a device 
tree but in less maintainable form in the kernel source.

-Scott
