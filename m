Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 7245BDDF91
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 18:16:22 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [linux-usb-devel] [PATCH 0/3] usb: ehci ppc device-tree-aware
	driver
Date: Wed, 10 Oct 2007 10:15:45 +0200
References: <20070924192519.GA4192@ru.mvista.com>
	<200710092327.26109.david-b@pacbell.net>
In-Reply-To: <200710092327.26109.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710101015.46308.arnd@arndb.de>
Cc: David Brownell <david-b@pacbell.net>, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 10 October 2007, David Brownell wrote:
> On Monday 24 September 2007, Valentine Barshak wrote:
> > Some PowerPC systems have a built-in EHCI controller.
> > This is a device tree aware version of the EHCI controller driver.
> > Currently it's been tested on the PowerPC 440EPx Sequoia board.
> > Other platforms can be added later.
> > The code is based on the ehci-ppc-soc driver by Stefan Roese <sr@denx.de>.
> 
> Do PPC folk sign off on how this is done?
> 
> I don't follow all the ins/outs of the OF devtree stuff...

The driver looks good to me, both the interaction with the of_platform_bus
layer and the handling of I/O addresses. I haven't actually tried running
it, but I'm rather confident that if it works on the Sequoia, it should
also do the right thing on any other powerpc system that has an EHCI on
some other (non-PCI) bus.

Acked-by: Arnd Bergmann <arnd@arndb.de>
