Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-40-242-100.roch.qwest.net
	[67.40.242.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EA3EA67BFF
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 22:57:18 +1000 (EST)
Subject: Re: RFC: Location for Device Tree Sources?
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1155122309.4040.94.camel@localhost.localdomain>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<1155122309.4040.94.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 07:56:45 -0500
Message-Id: <1155128205.3944.1.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-09 at 13:18 +0200, Benjamin Herrenschmidt wrote:
> On Tue, 2006-08-01 at 15:32 -0500, Jon Loeliger wrote:
> > Folks,
> > 
> > Where should we place the sources for the OF Flat Device
> > Tree source files?  They used to be in U-Boot, but that
> > isn't happening any more.
> 
> Why ? While having device-tree's in zImages is good to handle firmwares
> that can't pass them, I still think that the proper thing to do is to
> have the firmware provide the DT to the kernel. Did Denk decide once for
> all against having DTs passed by uboot at all ? In which case, it's
> probably time to consider a fork...

We're only talking about the _source_ files.  The .dts files.  Not the
binary trees themselves.

The basic summary is that having a .dts in the kernel for every
defconfig would be good.  (I think that was the summary anyway.)

josh
