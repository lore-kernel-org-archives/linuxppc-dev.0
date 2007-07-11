Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8625ADDE3B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jul 2007 01:25:39 +1000 (EST)
Message-ID: <4694F66D.2010907@freescale.com>
Date: Wed, 11 Jul 2007 10:25:33 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurent.pinchart@technotrade.biz>
Subject: Re: [PATCH] [POWERPC] Move generic MPC82xx functions out of
	ADS-specific
References: <200707101312.46052.laurent.pinchart@technotrade.biz>
	<20070710180526.GA14935@ld0162-tx32.am.freescale.net>
	<200707110928.55339.laurent.pinchart@technotrade.biz>
In-Reply-To: <200707110928.55339.laurent.pinchart@technotrade.biz>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Laurent Pinchart wrote:
> On Tuesday 10 July 2007 20:05, Scott Wood wrote:
>>Why are you also moving mpc82xx_ads_show_cpuinfo() to the board file?
>>It's not really ADS-specific; it should just be renamed.
> 
> 
> For the MPC82xx ADS boards, mpc82xx_ads_show_cpuinfo() prints
> 
> Vendor		: Freescale Semiconductor
> Machine		: PQ2 ADS PowerPC
> 
> The vendor string is hardcoded to "Freescale Semiconductor", and the machine 
> string is defined in pq2ads.h. What should show_cpuinfo() print ? Should the 
> vendor be the board vendor or the CPU vendor ? What about the machine ?

Ah, I missed that.  I'd just get rid of "Vendor" altogether, and include 
the vendor name in the machine name.

-Scott
