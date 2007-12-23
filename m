Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 60AE2DDE26
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 13:58:47 +1100 (EST)
Message-ID: <476DCECD.6040008@freescale.com>
Date: Sat, 22 Dec 2007 20:58:21 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>	<20071220040633.GA6732@lixom.net>
	<476A7B23.2040905@freescale.com>	<20071220223943.GA24138@lixom.net>
	<476AEEB3.2010403@freescale.com> <476AF015.5040600@freescale.com>
In-Reply-To: <476AF015.5040600@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Scott Wood wrote:

>> None of the SOC nodes in any DTS have a "compatible" entry.
> 
> Not quite true; ep88xc, mpc8272ads, and pq2fads have them.

Ah ok.  So what should the compatible entry for 8641 be?

	compatible = "fsl,mpc8641"

That looks a lot like what a compatible entry for the CPU should be. 
How are we differentiating between the compatible cores and compatible SOCs?
