Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6AF7A2BDB5
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Nov 2004 12:59:20 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frank Murphy <murphyf+xfree86@f-m.fm>
In-Reply-To: <200411270948.08054.murphyf+xfree86@f-m.fm>
References: <200411232008.16854.murphyf+xfree86@f-m.fm>
	<41A70567.8050000@petig-baender.de> <1101517373.4668.2.camel@gaston>
	<200411270948.08054.murphyf+xfree86@f-m.fm>
Content-Type: text/plain
Date: Sun, 28 Nov 2004 12:58:12 +1100
Message-Id: <1101607094.5176.0.camel@gaston>
Mime-Version: 1.0
Cc: debian-x@lists.debian.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: G3 iBook LCD brightness in X under kernel 2.4.25 and 2.6.8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> r.
> 
> So I've tried this using the stock Debian 2.6.8 and 2.6.9 PPC kernels with the 
> same results.
> 
> $ grep ATY /boot/config-2.6.9-powerpc
> CONFIG_FB_ATY128=y
> CONFIG_FB_ATY=y
> CONFIG_FB_ATY_CT=y
> CONFIG_FB_ATY_GX=y
> # CONFIG_FB_ATY_XL_INIT is not set
> 
> It seems that the atyfb module is compiled in. Is there another way to check?

Check the bits in CONFIG_PMAC_BACKLIGHT in atyfb (like, add some
printk's to see if they are reached etc..)

Ben
