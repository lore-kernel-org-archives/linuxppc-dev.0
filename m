Return-Path: <B10812@freescale.com>
From: Aggrwal Poonam-B10812 <B10812@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Kushwaha Prabhakar-B32579
	<B32579@freescale.com>
Subject: RE: [PATCH] powerpc/85xx:DTS: Fix tbi node location for Px020RDB
Date: Thu, 23 Jun 2011 07:24:06 +0000
Message-ID: <45903308677306428B6EE7E6FF5A52041419B6@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1307501379-3160-1-git-send-email-prabhakar@freescale.com>
	<F9CD495E-12BF-467D-BE96-CC11486F70B8@kernel.crashing.org>
In-Reply-To: <F9CD495E-12BF-467D-BE96-CC11486F70B8@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "meet2prabhu@gmail.com" <meet2prabhu@gmail.com>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linuxppc-dev-bounces+poonam.aggrwal=3Dfreescale.com@lists.ozlabs.or=
g
> [mailto:linuxppc-dev-
> bounces+poonam.aggrwal=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Kum=
ar
> Gala
> Sent: Wednesday, June 22, 2011 5:04 PM
> To: Kushwaha Prabhakar-B32579
> Cc: meet2prabhu@gmail.com; devicetree-discuss@lists.ozlabs.org; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH] powerpc/85xx:DTS: Fix tbi node location for Px020RDB
>=20
>=20
> On Jun 7, 2011, at 9:49 PM, Prabhakar Kushwaha wrote:
>=20
> > ten-bit interface (TBI) module is part of SoC not board.
> >
> > Move tbi entries from board related dts files to Si dts.
> >
> > Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> > ---
> > Based upon
> http://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git (branch
> next)
> >
> > arch/powerpc/boot/dts/p1020rdb.dts            |    9 ---------
> > arch/powerpc/boot/dts/p1020rdb_camp_core0.dts |    8 --------
> > arch/powerpc/boot/dts/p1020si.dtsi            |    6 +++++-
> > arch/powerpc/boot/dts/p2020rdb.dts            |    8 --------
> > arch/powerpc/boot/dts/p2020rdb_camp_core0.dts |    8 --------
> > arch/powerpc/boot/dts/p2020si.dtsi            |    6 +++++-
> > 6 files changed, 10 insertions(+), 35 deletions(-)
> >
> > diff --git a/arch/powerpc/boot/dts/p1020rdb.dts
> b/arch/powerpc/boot/dts/p1020rdb.dts
> > index d6a8ae4..a4e5d6c 100644
> > --- a/arch/powerpc/boot/dts/p1020rdb.dts
> > +++ b/arch/powerpc/boot/dts/p1020rdb.dts
> > @@ -211,14 +211,6 @@
> > 			};
> > 		};
> >
> > -		mdio@25000 {
> > -
> > -			tbi0: tbi-phy@11 {
> > -				reg =3D <0x11>;
> > -				device_type =3D "tbi-phy";
> > -			};
> > -		};
> > -
> > 		enet0: ethernet@b0000 {
> > 			fixed-link =3D <1 1 1000 0 0>;
> > 			phy-connection-type =3D "rgmii-id";
> > @@ -227,7 +219,6 @@
> >
> > 		enet1: ethernet@b1000 {
> > 			phy-handle =3D <&phy0>;
> > -			tbi-handle =3D <&tbi0>;
> > 			phy-connection-type =3D "sgmii";
> >
> > 		};
>=20
> I'm not sure we should do this.  The phy address we pick is board
> specific so it should NOT be in .dtsi
The TBI phy and it's address is internal to SOC.

Regards
Poonam
>=20
> - k
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
