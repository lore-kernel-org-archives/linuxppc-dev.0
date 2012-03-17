Return-Path: <B10812@freescale.com>
From: Aggrwal Poonam-B10812 <B10812@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] Device Tree Bindings for Freescale TDM controller
Date: Sat, 17 Mar 2012 07:33:32 +0000
Message-ID: <ACB6D0C0104CFF42A45A5D82A0DD4F3D09D518@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1331861451-15427-1-git-send-email-poonam.aggrwal@freescale.com>
 <4F63868D.1030507@freescale.com>
In-Reply-To: <4F63868D.1030507@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "devicetree-discuss@lists.ozlabs.org"
 <devicetree-discuss@lists.ozlabs.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Singh Sandeep-B37400 <B37400@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Scott for the review.

Will send an updated revision with the comments taken care.

Regards
Poonam

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Saturday, March 17, 2012 12:00 AM
> To: Aggrwal Poonam-B10812
> Cc: devicetree-discuss@lists.ozlabs.org; linuxppc-dev@lists.ozlabs.org;
> Singh Sandeep-B37400
> Subject: Re: [PATCH] Device Tree Bindings for Freescale TDM controller
>=20
> On 03/15/2012 08:30 PM, Poonam Aggrwal wrote:
> > From: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> >
> > This TDM controller is available in various Freescale SOCs like
> > MPC8315, P1020, P1022, P1010.
> >
> > Signed-off-by: Sandeep Singh <Sandeep@freescale.com>
> > Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> > ---
> >  Documentation/devicetree/bindings/tdm/fsl-tdm.txt |   71
> +++++++++++++++++++++
> >  1 files changed, 71 insertions(+), 0 deletions(-)  create mode 100644
> > Documentation/devicetree/bindings/tdm/fsl-tdm.txt
> >
> > diff --git a/Documentation/devicetree/bindings/tdm/fsl-tdm.txt
> > b/Documentation/devicetree/bindings/tdm/fsl-tdm.txt
> > new file mode 100644
> > index 0000000..61431e3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/tdm/fsl-tdm.txt
> > @@ -0,0 +1,71 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +TDM Device Tree Binding
> > +Copyright (C) 2012 Freescale Semiconductor Inc.
> > +
> > +NOTE: The bindings described in this document are preliminary and
> > +subject to change.
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +TDM (Time Division Multiplexing)
> > +
> > +DESCRIPTION
> > +
> > +The TDM is full duplex serial port designed to allow various devices
> > +including digital signal processors (DSPs) to communicate with a
> > +variety of serial devices including industry standard framers, codecs,
> other DSPs and microprocessors.
> > +
> > +The below properties describe the device tree bindings for Freescale
> > +TDM controller.
> > +This TDM controller is available on various Freescale Processors like
> > +MPC8313, P1020, P1022 and P1010.
> > +
> > +PROPERTIES
> > +
> > +  - compatible
> > +      Usage: required
> > +      Value type: <string>
> > +      Definition: Should contain "fsl,mpc8315-tdm".
> > +	  So mpc8313 will have compatible =3D "fsl,mpc8315-tdm";
> > +	  p1010 will have compatible "fsl,p1010-tdm", "fsl,mpc8315-tdm";
>=20
> Shouldn't mpc8313 have:
> compatible =3D "fsl,mpc8313-tdm", "fsl,mpc8315-tdm"?
>=20
> I thought we were going to use 8313 as the canonical implementation, not
> 8315.
MPC8315 was the first FSL platform to have this controller.
MPC8313 does not have TDM.
>=20
> > +  - reg
> > +      Usage: required
> > +      Value type: <tdm-reg-offset tdm-reg-size dmac-reg-offset dmac-
> reg-size>
> > +      Definition: A standard property. Specifies the physical address
> > +	  offset and length of the TDM registers and TDM DMAC registers for
> > +	  the device.
>=20
> Just say there's two reg resources, and that the first is the TDM
> registers and the second is the TDM DMAC registers.
>=20
> It's typically not going to be the actual physical address, but rather an
> offset that gets translated through a parent node's ranges.
Okay, I think we missed this comment, you already gave this earlier.
Sorry for that.
>=20
> Remove "value type"; it's standard.
>=20
Okay. So just definition must suffice, right?
> > +  - clock-frequency
> > +      Usage: optional
> > +      Value type: <u32>
> > +      Definition: The frequency at which the TDM block is operating.
>=20
> Will this frequency ever need to be > 4GHz?
Don't think so, at max this will be CCB, not sure if CCB on our platforms m=
ay get bigger than 4G ever.
>=20
> Might want to specify as u32 or u64, as ePAPR suggests.
Means Value type: <u32 or u64>?
In this case the driver must always use 64bit data structure to read this. =
Is this correct?
>=20
> > +  - interrupts
> > +      Usage: required
> > +      Value type: <tdm-err-intr tdm-err-intr-type dmac-intr dmac-intr-
> type>
> > +      Definition: This field defines two interrupt specifiers namely
> interrupt
> > +	  number and interrupt type for TDM error and TDM DMAC.
>=20
> What is "tdm-err-intr-type"?  The interrupt specifier encoding is defined
> by the interrupt controller.  There might be one cell, two cells, four
> cells, etc.  Remove "value type", it's standard.
>=20
okay
> > +  - phy-handle
> > +      Usage: optional
> > +      Value type: <phandle>
> > +      Definition: Phandle of the line controller node or framer node
> eg. SLIC,
> > +	  E1\T1 etc.
>=20
> Use a forward slash -- this isn't a Windows filesystem path. :-)
>=20
Okay, agreed.
> > +  - fsl-max-time-slots
> > +      Usage: required
> > +      Value type: <u32>
> > +      Definition: Maximum number of 8-bit time slots in one TDM frame.
> > +	  This is the maximum number which TDM hardware supports.
>=20
> fsl,tdm-max-time-slots
Sure. This again got missed.
>=20
> > +
> > +EXAMPLE
> > +
> > +	tdm@16000 {
> > +		device_type =3D "tdm";
>=20
> No device_type
Okay.
>=20
> > +		compatible =3D "fsl,p1010-tdm", "fsl,mpc8315-tdm";
> > +		reg =3D <0x16000 0x200 0x2c000 0x2000>;
> > +		clock-frequency =3D <0>;
>=20
> Show a real clock-frequency, perhaps with a comment saying it's typically
> filled in by boot software.
Okay.
>=20
> > +		interrupts =3D <16 8 62 8>;
> > +		phy-handle =3D <zarlink1>
>=20
> That phy-handle is invalid syntax, perhaps you meant:
>=20
> 	phy-handle =3D <&zarlink1>;
Yes. Will correct it.
>=20
> > +		fsl-max-time-slots =3D <128>
>=20
> Missing semicolons on the last two properties.
>=20
Ok.
> -Scott
