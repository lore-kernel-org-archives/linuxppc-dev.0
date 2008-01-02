Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2C1CADDEE8
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 05:09:21 +1100 (EST)
Date: Wed, 2 Jan 2008 12:08:30 -0600
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Message-ID: <20080102180830.GC4398@loki.buserror.net>
References: <11981089894052-git-send-email-timur@freescale.com>
	<20071220040633.GA6732@lixom.net> <476A7B23.2040905@freescale.com>
	<20071220223943.GA24138@lixom.net> <476AEEB3.2010403@freescale.com>
	<476AF015.5040600@freescale.com> <476DCECD.6040008@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <476DCECD.6040008@freescale.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 22, 2007 at 08:58:21PM -0600, Timur Tabi wrote:
> Scott Wood wrote:
>
>>> None of the SOC nodes in any DTS have a "compatible" entry.
>>
>> Not quite true; ep88xc, mpc8272ads, and pq2fads have them.
>
> Ah ok.  So what should the compatible entry for 8641 be?
>
> 	compatible = "fsl,mpc8641"

Yes.

> That looks a lot like what a compatible entry for the CPU should be.

I guess technically the cpu should list something like fsl,e600 (or
whatever suffix is relevant).

-Scott
