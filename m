Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D61D32BDF2
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Nov 2004 10:27:49 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
In-Reply-To: <Pine.LNX.4.44.0411231224150.7434-100000@zirkon.biophys.uni-duesseldorf.de>
References: <Pine.LNX.4.44.0411231224150.7434-100000@zirkon.biophys.uni-duesseldorf.de>
Content-Type: text/plain
Date: Wed, 24 Nov 2004 10:27:03 +1100
Message-Id: <1101252423.24531.23.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: TEST: Sleep patch #4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Looking at radeon_base.c:radeon_screen_blank() (line 1045) we have:
> 
>                         val &= ~(LVDS_BL_MOD_EN);
>                         udelay(100);
>                         val &= ~(LVDS_ON | LVDS_EN);
>                         OUTREG(LVDS_GEN_CNTL, val);
> 
> 
> Is there an OUTREG(LVDS_GEN_CNTL, val); missing before the udelay(100) ??
> 
> That's in the panel blank code, not the unblank code though. Doesn't seem
> to hurt to put the OUTREG in.

won't hurt, dunno if it will help tho... could also be a different
issue, like the spread spectrum PLL not locking properly or something
like that ... I don't really know.

Ben.
