Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 671EBDDFC9
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 01:45:36 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9NFjXlb009911
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 11:45:33 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9NFcRmr054368
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 09:45:32 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9NFb57K032503
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 09:37:05 -0600
Date: Tue, 23 Oct 2007 10:37:00 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] [PATCH 0/3] usb: ehci ppc device-tree-aware
	driver
Message-ID: <20071023103700.595e9abd@weaponx.rchland.ibm.com>
In-Reply-To: <200710101030.02349.sr@denx.de>
References: <20070924192519.GA4192@ru.mvista.com>
	<200710092327.26109.david-b@pacbell.net>
	<200710101015.46308.arnd@arndb.de> <200710101030.02349.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	linux-usb-devel@lists.sourceforge.net, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 10 Oct 2007 10:30:02 +0200
Stefan Roese <sr@denx.de> wrote:

> On Wednesday 10 October 2007, Arnd Bergmann wrote:
> > > Do PPC folk sign off on how this is done?
> > >
> > > I don't follow all the ins/outs of the OF devtree stuff...
> >
> > The driver looks good to me, both the interaction with the of_platform_bus
> > layer and the handling of I/O addresses. I haven't actually tried running
> > it, but I'm rather confident that if it works on the Sequoia, it should
> > also do the right thing on any other powerpc system that has an EHCI on
> > some other (non-PCI) bus.
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Stefan Roese <sr@denx.de>

David, were you going to pull in the echi-ppc-of driver (patch 1 of
this series) for 2.6.24?  Just trying to figure out if I need to pull
the other two patches into my tree.

josh
