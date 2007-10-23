Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound5-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 674E7DDFC9
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 02:25:11 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [microblaze-uclinux] Re: [microblaze-uclinux] RE: [PATCH v3]
	Device tree bindings for Xilinx devices
Date: Tue, 23 Oct 2007 09:25:02 -0700
In-Reply-To: <1837.2996-6584-798350907-1193112476@seznam.cz>
References: <20071022180700.8B3938E0088@mail19-fra.bigfish.com>
	<1837.2996-6584-798350907-1193112476@seznam.cz>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Michal Simek" <Monstr@seznam.cz>,
	<microblaze-uclinux@itee.uq.edu.au>
Message-Id: <20071023162504.CAFF01690066@mail124-blu.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
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
zlabs.org] On Behalf Of Michal Simek
> Sent: Monday, October 22, 2007 9:08 PM
> To: microblaze-uclinux@itee.uq.edu.au
> Cc: Leonid; Wolfgang Reissnegger; Arnd Bergmann;=20
> linuxppc-dev@ozlabs.org
> Subject: RE: [microblaze-uclinux] Re: [microblaze-uclinux]=20
> RE: [PATCH v3] Device tree bindings for Xilinx devices
>=20
> >> In my opinion will be better generate only parameters which=20
> >> you want not all.
> >> That smells with unusable parameters.
> >
> >In the long term, this may be true.  In the short term:
> >1) dtb size is not the key problem
> Yes of course
> >2) making sure that everything works is a key problem.
> >3) The code that generates the dts should be as simple as possible,
> >so that we can easily document what it does.
> Yes but you must document every parameter which your generate=20
> do. The better way is=20
> document only parameters which you want use.

No, that's exactly my point.  The generator should document what it
*does*
i.e.  When there is a parameter in the EDK file, then such and such
corresponding parameter will be generated in the dts.  The devices and
drivers
will inevitably change over time: your proposal would result in
an unnecessary maintenance headache...  The documentation of what the
individual
parameters are should be unambiguous from the EDK documentation.

The only things that the generator should handle 'specially', in my
opinion
are parameters that need to be munged to be standard names.

Steve
