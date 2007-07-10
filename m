Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6AA00DDE20
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 04:05:35 +1000 (EST)
Date: Tue, 10 Jul 2007 13:05:27 -0500
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurent.pinchart@technotrade.biz>
Subject: Re: [PATCH] [POWERPC] Move generic MPC82xx functions out of
	ADS-specific
Message-ID: <20070710180526.GA14935@ld0162-tx32.am.freescale.net>
References: <200707101312.46052.laurent.pinchart@technotrade.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200707101312.46052.laurent.pinchart@technotrade.biz>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Jul 10, 2007 at 01:12:45PM +0200, Laurent Pinchart wrote:
> The non board-specific mpc82xx_halt and mpc82xx_restart functions are defined
> in arch/powerpc/platforms/82xx/mpc82xx_ads.c. This patch moves them to
> mpc82xx.c to make them usable by other MPC82xx boards.

Why are you also moving mpc82xx_ads_show_cpuinfo() to the board file? 
It's not really ADS-specific; it should just be renamed.

-Scott
