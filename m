Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound1-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 541A3DDEFA
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 08:38:48 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] [POWERPC] Xilinx: add compatibility for IBM coreconnect
	busses.
Date: Wed, 7 May 2008 15:38:32 -0700
In-reply-to: <fa686aa40805071533m546b4954u1c6e88e7224f035c@mail.gmail.com>
References: <20080507204734.574B6185804E@mail138-sin.bigfish.com>
	<fa686aa40805071533m546b4954u1c6e88e7224f035c@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20080507223845.0174E7E0068@mail59-va3.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Agreed...  I intend the backward compatibility to be a temporary thing.
I'd rip it out now, but since we pull out all the information from the
device tree, this will result in 'it doesn't do anything', and I don't
want to be that mean. :)

Steve

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of
Grant Likely
> Sent: Wednesday, May 07, 2008 3:33 PM
> To: Stephen Neuendorffer
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] [POWERPC] Xilinx: add compatibility for IBM
coreconnect busses.
>=20
> On Wed, May 7, 2008 at 2:47 PM, Stephen Neuendorffer
> <stephen.neuendorffer@xilinx.com> wrote:
> > The IBM coreconnect names are pretty well defined, it appears.  In
> >  addition, the Xilinx versions of these IPs seem to be
proliferating.
> >  Hence, in the future let's prefer to use the standard names.  I've
> >  left the old names in for some backward compatibility for existing
> >  device trees.
> >
> >  Signed-off-by: Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com>
>=20
> Acked-by: Grant Likely <grant.likey@secretlab.ca>
>=20
> I think we can probably give it a release or two and then drop the
> older stuff in the list.  Virtex support is still very new, so it is
> unlikely that there are many (any?) users out there that won't be
> keeping up to date with the xilinx device tree changes.
>=20
> Cheers,
> g.
>=20
> >  ---
> >   arch/powerpc/platforms/40x/virtex.c |    4 ++++
> >   1 files changed, 4 insertions(+), 0 deletions(-)
> >
> >  diff --git a/arch/powerpc/platforms/40x/virtex.c
b/arch/powerpc/platforms/40x/virtex.c
> >  index 6c72994..7e1c0e3 100644
> >  --- a/arch/powerpc/platforms/40x/virtex.c
> >  +++ b/arch/powerpc/platforms/40x/virtex.c
> >  @@ -16,11 +16,15 @@
> >   #include <asm/xilinx_intc.h>
> >
> >   static struct of_device_id xilinx_of_bus_ids[] __initdata =3D {
> >  +       { .compatible =3D "ibm,plb3", },
> >  +       { .compatible =3D "ibm,plb4", },
> >         { .compatible =3D "xlnx,plb-v46-1.00.a", },
> >         { .compatible =3D "xlnx,plb-v46-1.02.a", },
> >         { .compatible =3D "xlnx,plb-v34-1.01.a", },
> >         { .compatible =3D "xlnx,plb-v34-1.02.a", },
> >  +       { .compatible =3D "ibm,opb", },
> >         { .compatible =3D "xlnx,opb-v20-1.10.c", },
> >  +       { .compatible =3D "ibm,dcr", },
> >         { .compatible =3D "xlnx,dcr-v29-1.00.a", },
> >         { .compatible =3D "xlnx,compound", },
> >         {}
> >  --
> >  1.5.3.4
> >
> >
> >
> >
>=20
>=20
>=20
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
