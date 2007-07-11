Return-Path: <laurent.pinchart@technotrade.biz>
Received: from mailrelay002.isp.belgacom.be (mailrelay002.isp.belgacom.be
	[195.238.6.175]) by ozlabs.org (Postfix) with ESMTP id AC11FDDE21
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 17:28:59 +1000 (EST)
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [POWERPC] Move generic MPC82xx functions out of
	ADS-specific
Date: Wed, 11 Jul 2007 09:28:55 +0200
References: <200707101312.46052.laurent.pinchart@technotrade.biz>
	<20070710180526.GA14935@ld0162-tx32.am.freescale.net>
In-Reply-To: <20070710180526.GA14935@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707110928.55339.laurent.pinchart@technotrade.biz>
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

On Tuesday 10 July 2007 20:05, Scott Wood wrote:
> On Tue, Jul 10, 2007 at 01:12:45PM +0200, Laurent Pinchart wrote:
> > The non board-specific mpc82xx_halt and mpc82xx_restart functions are
> > defined in arch/powerpc/platforms/82xx/mpc82xx_ads.c. This patch moves
> > them to mpc82xx.c to make them usable by other MPC82xx boards.
>
> Why are you also moving mpc82xx_ads_show_cpuinfo() to the board file?
> It's not really ADS-specific; it should just be renamed.

For the MPC82xx ADS boards, mpc82xx_ads_show_cpuinfo() prints

Vendor		: Freescale Semiconductor
Machine		: PQ2 ADS PowerPC

The vendor string is hardcoded to "Freescale Semiconductor", and the machine 
string is defined in pq2ads.h. What should show_cpuinfo() print ? Should the 
vendor be the board vendor or the CPU vendor ? What about the machine ?

Laurent Pinchart
