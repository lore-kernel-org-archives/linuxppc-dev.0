Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0656ADDDD5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jul 2007 01:21:34 +1000 (EST)
Message-ID: <4694F578.70901@freescale.com>
Date: Wed, 11 Jul 2007 10:21:28 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurent.pinchart@technotrade.biz>
Subject: Re: MPC82xx ADS SCC ports initialisation
References: <200707101619.52438.laurent.pinchart@technotrade.biz>
	<20070710181133.GB14935@ld0162-tx32.am.freescale.net>
	<200707110911.19477.laurent.pinchart@technotrade.biz>
In-Reply-To: <200707110911.19477.laurent.pinchart@technotrade.biz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: vbordug@ru.mvista.com, linuxppc-embedded@ozlabs.org
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
> That code should be replaced with calls to cpm2_clk_setup 
> (arch/powerpc/sysdev/cpm2_common.c). cpm2_clk_setup currently supports FCC 
> clock setup only, but I've got a patch to add SCC clock setup support. Should 
> I send it ?

It's already done in my working tree; I should have it picked apart into 
postable patches in the next few days.

-Scott
