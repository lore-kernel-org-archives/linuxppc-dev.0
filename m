Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7233DDDE42
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 04:08:53 +1000 (EST)
Date: Thu, 30 Aug 2007 13:04:50 -0500
From: Scott Wood <scottwood@freescale.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Document and implement an improved flash device binding for
	powerpc (v4)
Message-ID: <20070830180450.GA3757@ld0162-tx32.am.freescale.net>
References: <20070830012118.GF22844@localhost.localdomain>
	<20070830172932.GA3317@ld0162-tx32.am.freescale.net>
	<20070830125952.14c700ea@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070830125952.14c700ea@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 30, 2007 at 12:59:52PM -0500, Josh Boyer wrote:
> On Thu, 30 Aug 2007 12:29:33 -0500
> Scott Wood <scottwood@freescale.com> wrote:
> 
> > On Thu, Aug 30, 2007 at 11:21:18AM +1000, David Gibson wrote:
> > > +    For JEDEC compatible devices, the following additional properties
> > > +    are defined:
> > > +
> > > +     - vendor-id : Contains the flash chip's vendor id (1 byte).
> > > +     - device-id : Contains the flash chip's device id (1 byte).
> > 
> > Are these required, or recommended?
> 
> For JEDEC, I believe those are required.

It can be probed, though...

-Scott
