Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail38-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 54CBBDDEF0
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 03:25:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Refactor booting-without-of.txt
Date: Tue, 16 Oct 2007 10:24:51 -0700
In-Reply-To: <20071016032415.GO26787@localhost.localdomain>
References: <fa686aa40710150908o55d1f5d2t264cbb8ed800a12f@mail.gmail.com><20071015165505.GA16040@lixom.net><fa686aa40710151014q5e151ea9w3f589d9e89e95905@mail.gmail.com><20071016023845.GK26787@localhost.localdomain><fa686aa40710152002l5bb2c746i8174827e8d66c746@mail.gmail.com>
	<20071016032415.GO26787@localhost.localdomain>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "David Gibson" <david@gibson.dropbear.id.au>,
	"Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20071016172509.08B73FE0077@mail38-dub.bigfish.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
> -----Original Message-----
> From:=20
> linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.or
> g=20
> [mailto:linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@o
zlabs.org] On Behalf Of David Gibson
> Sent: Monday, October 15, 2007 8:24 PM
> To: Grant Likely
> Cc: Olof Johansson; linuxppc-dev; microblaze-uclinux@itee.uq.edu.au
> Subject: Re: Refactor booting-without-of.txt
>=20
> On Mon, Oct 15, 2007 at 09:02:09PM -0600, Grant Likely wrote:
> > On 10/15/07, David Gibson <david@gibson.dropbear.id.au> wrote:
> > > On Mon, Oct 15, 2007 at 11:14:44AM -0600, Grant Likely wrote:
> > > > On 10/15/07, Olof Johansson <olof@lixom.net> wrote:
> > > > > On Mon, Oct 15, 2007 at 10:08:44AM -0600, Grant Likely wrote:
> > > > > > Adding the Linux expected device tree bindings to
> > > > > > booting-without-of.txt seems to be getting a little=20
> unwieldy.  Plus
> > > > > > with more than one arch using the device tree=20
> (powerpc, sparc &
> > > > > > microblaze) the device tree bindings aren't=20
> necessarily powerpc only
> > > > > > (the Xilinx devices certainly fall in this category).
> > > > > >
> > > > > > Anyone have comments about splitting the expected=20
> device tree bindings
> > > > > > out of booting-without-of.txt into a separate directory?
> > > > >
> > > > > The flat device tree is, in spite of what some people=20
> would like it to be,
> > > > > not open firmware, nor is it the same as their=20
> bindings. So I think we'd
> > > > > be doing ourselves a disservice by continuing to=20
> associate them together.
> > > > > All it would take is a rename of the directory,=20
> unfortunately i don't
> > > > > have any suggestions on better names though.
> > > >
> > > > I think I need to stick with the of prefix.  All the=20
> support API in
> > > > include/linux/of_* is prefixed with "of_" already, so=20
> convention is
> > > > established.
> > > >
> > > > How about Documentation/of-device-tree?
> > >
> > > It seems a little counterintuitive to change names from "booting
> > > *without* of" to "of *"...
> >=20
> > Heh; true.  The *only* reason I think it should be=20
> 'of-<anything>' is
> > because *all* the support APIs are named that way.  I'll happily use
>=20
> No, not all, just most...
>=20
> And do bear in mind that a lot of those accessor functions are at
> least valid both on of and flat-tree systems.
>=20
> > another name if I get the impression that most of us in our little
> > group think it should be something else.
> >=20
> > Cheers,
> > g.
> >=20
> >=20
>

How about just 'device-tree', referring to any source, and then
of-device-tree and flat-device-tree to document how the device tree is
constructed.
The fact that the API is poorly named is something that can always be
fixed (and perhaps should be earlier rather than later).

Steve
