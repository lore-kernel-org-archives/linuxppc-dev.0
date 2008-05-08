Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id ABDD1DDEC6
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 02:17:28 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] [POWERPC] Xilinx: add compatibility for IBMcoreconnect
	busses.
Date: Thu, 8 May 2008 09:15:27 -0700
In-reply-to: <20080508033006.GH5156@yookeroo.seuss>
References: <20080507204734.574B6185804E@mail138-sin.bigfish.com><20080508001850.GB5156@yookeroo.seuss><20080507214630.2f13fd22@zod.rchland.ibm.com>
	<20080508033006.GH5156@yookeroo.seuss>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "David Gibson" <dwg@au1.ibm.com>, "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Message-Id: <20080508161529.65566FB805F@mail185-va3.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hmm... sounds reasonable to me.

> -----Original Message-----
> From: =
linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of =
David
Gibson
> Sent: Wednesday, May 07, 2008 8:30 PM
> To: Josh Boyer
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] [POWERPC] Xilinx: add compatibility for
IBMcoreconnect busses.
>=20
> On Wed, May 07, 2008 at 09:46:30PM -0500, Josh Boyer wrote:
> > On Thu, 8 May 2008 10:18:50 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >
> > > On Wed, May 07, 2008 at 01:47:31PM -0700, Stephen Neuendorffer
wrote:
> > > > The IBM coreconnect names are pretty well defined, it appears.
In
> > > > addition, the Xilinx versions of these IPs seem to be
proliferating.
> > > > Hence, in the future let's prefer to use the standard names.
I've
> > > > left the old names in for some backward compatibility for
existing
> > > > device trees.
> > > >
> > > > Signed-off-by: Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com>
> > >
> > > If you're talking about future trees, can't you just slap
"simple-bus"
> > > on them avoid this monster id table?
> >
> > What is that and how does it work?
>=20
> ePAPR states that busses which cannot be probed as such (i.e. the
> device tree is the only way to figure out what's on the bus) should
> have "simple-bus" in their compatible property.  You can then just add
> simple-bus to the of_bus_ids list and avoid adding umpteen other
things.
>=20
> --
> David Gibson			| I'll have my music baroque, and my
code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT
_the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
