Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1AF1DDF0C
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 07:55:21 +1100 (EST)
Subject: Re: [PATCH] powerpc/44x: Fix address decoding setup of PCI 2.x cells
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <alpine.LRH.2.00.0902031616130.21407@vixen.sonytel.be>
References: <20090202002429.ADA74DDF43@ozlabs.org>
	<20090203151050.GA10541@yoda.jdub.homelinux.org>
	<alpine.LRH.2.00.0902031616130.21407@vixen.sonytel.be>
Content-Type: text/plain
Date: Wed, 04 Feb 2009 07:55:08 +1100
Message-Id: <1233694508.16867.86.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Could it be my USB failures were due to the PPC440 USB host needing the various
> CONFIG*USB*BIG_ENDIAN* options, which may conflict with USB hosts on PCI
> plug-in cards?
> 
> The E1000 did work fine.

You need to enable support for both endians, that's supposed to work.

Ben.
