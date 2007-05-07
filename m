Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C67E6DDECF
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 23:17:26 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l47DHNM3020242
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 09:17:23 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l47DHN2V148592
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 07:17:23 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l47DHNjX030151
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 07:17:23 -0600
Subject: Re: [PATCH v2 6/7] Holly DTS
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20070506004044.GG11303@localhost.localdomain>
References: <1178381611.3393.25.camel@zod.rchland.ibm.com>
	<1178382006.3393.37.camel@zod.rchland.ibm.com>
	<e1d22829fe3f12509018791541073706@kernel.crashing.org>
	<20070506004044.GG11303@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 07 May 2007 08:11:52 -0500
Message-Id: <1178543512.2990.31.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-05-06 at 10:40 +1000, David Gibson wrote:
> On Sat, May 05, 2007 at 07:21:33PM +0200, Segher Boessenkool wrote:
> [snip]
> > > +	compatible = "ppc750-tsi";
> > 
> > The needs to be more specific as well; "ibm,holly"
> > or something.
> 
> Or perhaps just include something more specific, compatible can have
> the general version as well.
> 
> [snip]
> > > +	chosen {
> > > +		linux,platform = <0>;
> > > +		linux,initrd-start = <0>;
> > > +		linux,initrd-end = <0>;
> > 
> > Do you need to set those zero properties?
> 
> linux,platform is obsolete and should definitely go.  With the recent
> bootloader updates the initrd properties can also go (the bootloader
> will add them correctly).  I had them in the Ebony device tree until
> very recently because until some of the recent flatdevtree.c fixes,
> the bootloader could replace the value of the properties, but it
> couldn't add new properties (or at least not properties with new
> names).

s/bootloader/bootwrapper?

josh
