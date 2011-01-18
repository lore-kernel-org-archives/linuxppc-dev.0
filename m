Return-Path: <R61911@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe006.messaging.microsoft.com
	[213.199.154.209])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 71F39B70FF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Jan 2011 14:17:04 +1100 (EST)
From: Zang Roy-R61911 <R61911@freescale.com>
To: Sergei Shtylyov <sshtylyov@mvista.com>, Xu Lei-B33228
	<B33228@freescale.com>
Subject: RE: [PATCH] ATA: Add FSL sata v2 controller support
Date: Tue, 18 Jan 2011 03:01:24 +0000
Message-ID: <2239AC579C7D3646A720227A37E0268109001B@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1295248259-14752-1-git-send-email-B33228@freescale.com>
	<4D342C6E.6000608@ru.mvista.com>
In-Reply-To: <4D342C6E.6000608@ru.mvista.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "jgarzik@pobox.com" <jgarzik@pobox.com>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov@mvista.com]
> Sent: Monday, January 17, 2011 19:48 PM
> To: Xu Lei-B33228
> Cc: linuxppc-dev@lists.ozlabs.org; Gala Kumar-B11780; jgarzik@pobox.com;
> linux-ide@vger.kernel.org; Zang Roy-R61911
> Subject: Re: [PATCH] ATA: Add FSL sata v2 controller support
>=20
> Hello.
>=20
> On 17-01-2011 10:10, Xulei wrote:
>=20
> > In FSL sata v2 block, the snoop bit of PRDT Word3 description
> > information is at bit28 instead of bit22.
>=20
> > This patch adds FSL sata v2 probe and resolve this difference.
>=20
> > Signed-off-by: Xulei <B33228@freescale.com>
>=20
[snip]

> > diff --git a/arch/powerpc/boot/dts/p1022ds.dts
> b/arch/powerpc/boot/dts/p1022ds.dts
> > index 2bbecbb..9ad41dd 100644
> > --- a/arch/powerpc/boot/dts/p1022ds.dts
> > +++ b/arch/powerpc/boot/dts/p1022ds.dts
> > @@ -475,14 +475,14 @@
> >   		};
> >
> >   		sata@18000 {
> > -			compatible =3D "fsl,mpc8536-sata", "fsl,pq-sata";
> > +			compatible =3D "fsl,p1022-sata", "fsl,pq-sata-v2";
> >   			reg =3D<0x18000 0x1000>;
> >   			cell-index =3D<1>;
> >   			interrupts =3D<74 0x2>;
> >   		};
> >
> >   		sata@19000 {
> > -			compatible =3D "fsl,mpc8536-sata", "fsl,pq-sata";
> > +			compatible =3D "fsl,p1022-sata", "fsl,pq-sata-v2";
> >   			reg =3D<0x19000 0x1000>;
> >   			cell-index =3D<2>;
> >   			interrupts =3D<41 0x2>;
>=20
>     Please put this into the separate patch and push thru the PPC tree.
I agree to put to them to separate patches, but should we=20
pull in the separate patches to one candidate tree to make
the function work?
Thanks.
Roy
