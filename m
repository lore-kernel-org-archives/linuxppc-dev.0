Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (unknown [209.180.55.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CB125DDE11
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 00:01:18 +1000 (EST)
Date: Mon, 17 Sep 2007 09:00:39 -0500
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/3] usb: add device-tree-aware ehci driver
Message-ID: <20070917090039.7c05e3bc@weaponx.rchland.ibm.com>
In-Reply-To: <20070917232809.1221acd9.sfr@canb.auug.org.au>
References: <20070917125039.GA29525@ru.mvista.com>
	<20070917125543.GA29584@ru.mvista.com>
	<20070917232809.1221acd9.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 17 Sep 2007 23:28:09 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> On Mon, 17 Sep 2007 16:55:43 +0400 Valentine Barshak <vbarshak@ru.mvista.com> wrote:
> >
> > +++ linux-2.6/drivers/usb/host/ehci-ppc-of.c	2007-09-15 16:12:56.000000000 +0400
> > @@ -0,0 +1,220 @@
> > +
> > +#include <asm/of_platform.h>
> > +#include <asm/prom.h>
> 
> Please use linux/of.h and linux/of_platform.h instead.

This seems to be a common error these days.  Perhaps a #warning in the
asm/ files if _LINUX_OF_PLATFORM_H and _LINUX_OF_H aren't defined would
be helpful.

josh
