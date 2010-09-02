Return-Path: <B21284@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207]) by ozlabs.org (Postfix) with ESMTP id C1253B7182
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Sep 2010 19:24:01 +1000 (EST)
Received: from mail5-am1 (localhost.localdomain [127.0.0.1])	by
	mail5-am1-R.bigfish.com (Postfix) with ESMTP id B0C8A160024B	for
	<linuxppc-dev@ozlabs.org>; Thu,  2 Sep 2010 09:23:57 +0000 (UTC)
Received: from am1ehsmhs001.bigfish.com (unknown [10.3.201.243])	by
	mail5-am1.bigfish.com (Postfix) with ESMTP id 14DC346804C	for
	<linuxppc-dev@ozlabs.org>; Thu,  2 Sep 2010 09:23:57 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o828UL8f005031	for <linuxppc-dev@ozlabs.org>;
	Thu, 2 Sep 2010 01:30:21 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o828UQKa022071	for <linuxppc-dev@ozlabs.org>;
	Thu, 2 Sep 2010 03:30:27 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCH v2 6/6] DTS: add SPI flash(s25fl128p01) support on p4080ds
	and mpc8536ds board
Date: Thu, 2 Sep 2010 16:30:18 +0800
Message-ID: <73839B4A0818E747864426270AC332C30561B6D1@zmy16exm20.fsl.freescale.net>
In-Reply-To: <AANLkTinzea7-k3Wd6EsAy+ipThHMhkpMF3pCP7g_6O6J@mail.gmail.com>
References: <1280735524-17547-1-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-2-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-3-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-4-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-5-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-6-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-7-git-send-email-Mingkai.hu@freescale.com>
	<AANLkTinzea7-k3Wd6EsAy+ipThHMhkpMF3pCP7g_6O6J@mail.gmail.com>
From: Hu Mingkai-B21284 <B21284@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, Gala Kumar-B11780 <B11780@freescale.com>,
	Zang Roy-R61911 <R61911@freescale.com>,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of =
Grant
> Likely
> Sent: Tuesday, August 10, 2010 3:11 PM
> To: Hu Mingkai-B21284
> Cc: linuxppc-dev@ozlabs.org; spi-devel-general@lists.sourceforge.net; =
Gala
> Kumar-B11780; Zang Roy-R61911
> Subject: Re: [PATCH v2 6/6] DTS: add SPI flash(s25fl128p01) support on =
p4080ds
> and mpc8536ds board
>=20
> Hi Mingkai,
>=20
> one comment below.  Otherwise this patch looks good, and so does patch =
5.
>=20
> g.
>=20
> On Mon, Aug 2, 2010 at 1:52 AM, Mingkai Hu <Mingkai.hu@freescale.com> =
wrote:
> > Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> > ---
> >
> > v2:
> > =A0- Remove the whitespace inconsitencies
> >
> > =A0arch/powerpc/boot/dts/mpc8536ds.dts | =A0 52
> > +++++++++++++++++++++++++++++++++++
> > =A0arch/powerpc/boot/dts/p4080ds.dts =A0 | =A0 11 +++-----
> > =A02 files changed, 56 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts
> > b/arch/powerpc/boot/dts/mpc8536ds.dts
> > index 815cebb..a75c10e 100644
> > --- a/arch/powerpc/boot/dts/mpc8536ds.dts
> > +++ b/arch/powerpc/boot/dts/mpc8536ds.dts
> > @@ -108,6 +108,58 @@
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> >
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi@7000 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D =
<1>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D =
"fsl,mpc8536-espi";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x7000 =
0x1000>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <59 =
0x2>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D =
<&mpic>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
fsl,espi-num-chipselects =3D <4>;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flash@0 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
#address-cells =3D <1>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
#size-cells =3D <1>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
compatible =3D "spansion,s25sl12801";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =
=3D <0>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
spi-max-frequency =3D <40000000>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
partition@u-boot {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 label =3D "u-boot";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 reg =3D <0x00000000 0x00100000>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 read-only;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
partition@kernel {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 label =3D "kernel";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 reg =3D <0x00100000 0x00500000>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 read-only;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
partition@dtb {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 label =3D "dtb";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 reg =3D <0x00600000 0x00100000>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 read-only;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
partition@fs {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 label =3D "file system";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 reg =3D <0x00700000 0x00900000>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flash@1 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
compatible =3D "spansion,s25sl12801";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =
=3D <1>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
spi-max-frequency =3D <40000000>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flash@2 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
compatible =3D "spansion,s25sl12801";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =
=3D <2>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
spi-max-frequency =3D <40000000>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flash@3 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
compatible =3D "spansion,s25sl12801";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =
=3D <3>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
spi-max-frequency =3D <40000000>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > +
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma@21300 {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D =
<1>;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <1>; =
diff --git
> > a/arch/powerpc/boot/dts/p4080ds.dts
> > b/arch/powerpc/boot/dts/p4080ds.dts
> > index 6b29eab..48437ad 100644
> > --- a/arch/powerpc/boot/dts/p4080ds.dts
> > +++ b/arch/powerpc/boot/dts/p4080ds.dts
> > @@ -236,22 +236,19 @@
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spi@110000 {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D =
<1>;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <0>;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D =
"fsl,espi";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D =
"fsl,mpc8536-espi";
>=20
> Should be more specific here by specifying the exact device; plus a =
list of what
> it is compatible with.  For example:
>=20
> compatible =3D "fsl,p4080-espi", "fsl,mpc5836-espi";
>=20
> the reason for this is that the driver for the existing part is still =
able to
> bind against the node, but if it ever needs it, then information about =
the
> specific device is available which can be used to (for example) figure =
out when
> to enable silicon bug workarounds.
>=20

Make sense, I'll add it.

Thanks,
Mingkai
