Return-Path: <R61911@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ACCA7B7105
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Jan 2011 22:43:49 +1100 (EST)
From: Zang Roy-R61911 <R61911@freescale.com>
To: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: RE: [PATCH] ATA: Add FSL sata v2 controller support
Date: Tue, 18 Jan 2011 11:43:39 +0000
Message-ID: <2239AC579C7D3646A720227A37E02681090699@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1295248259-14752-1-git-send-email-B33228@freescale.com>
	<4D342C6E.6000608@ru.mvista.com>
	<2239AC579C7D3646A720227A37E0268109001B@039-SN1MPN1-004.039d.mgd.msft.net>
	<4D357918.4040001@ru.mvista.com>
In-Reply-To: <4D357918.4040001@ru.mvista.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	Xu Lei-B33228 <B33228@freescale.com>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"jgarzik@pobox.com" <jgarzik@pobox.com>
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
> Sent: Tuesday, January 18, 2011 19:27 PM
> To: Zang Roy-R61911
> Cc: Sergei Shtylyov; Xu Lei-B33228; linuxppc-dev@lists.ozlabs.org; Gala K=
umar-
> B11780; jgarzik@pobox.com; linux-ide@vger.kernel.org
> Subject: Re: [PATCH] ATA: Add FSL sata v2 controller support
>=20
> Hello.
>=20
> On 18-01-2011 6:01, Zang Roy-R61911 wrote:
>=20
> >>> In FSL sata v2 block, the snoop bit of PRDT Word3 description
> >>> information is at bit28 instead of bit22.
>=20
> >>> This patch adds FSL sata v2 probe and resolve this difference.
>=20
> >>> Signed-off-by: Xulei<B33228@freescale.com>
>=20
> > [snip]
>=20
> >>> diff --git a/arch/powerpc/boot/dts/p1022ds.dts
> >> b/arch/powerpc/boot/dts/p1022ds.dts
> >>> index 2bbecbb..9ad41dd 100644
> >>> --- a/arch/powerpc/boot/dts/p1022ds.dts
> >>> +++ b/arch/powerpc/boot/dts/p1022ds.dts
> >>> @@ -475,14 +475,14 @@
> >>>    		};
> >>>
> >>>    		sata@18000 {
> >>> -			compatible =3D "fsl,mpc8536-sata", "fsl,pq-sata";
> >>> +			compatible =3D "fsl,p1022-sata", "fsl,pq-sata-v2";
> >>>    			reg =3D<0x18000 0x1000>;
> >>>    			cell-index =3D<1>;
> >>>    			interrupts =3D<74 0x2>;
> >>>    		};
> >>>
> >>>    		sata@19000 {
> >>> -			compatible =3D "fsl,mpc8536-sata", "fsl,pq-sata";
> >>> +			compatible =3D "fsl,p1022-sata", "fsl,pq-sata-v2";
> >>>    			reg =3D<0x19000 0x1000>;
> >>>    			cell-index =3D<2>;
> >>>    			interrupts =3D<41 0x2>;
>=20
> >>      Please put this into the separate patch and push thru the PPC tre=
e.
>=20
> > I agree to put to them to separate patches, but should we
> > pull in the separate patches to one candidate tree to make
> > the function work?
>=20
>     I don't understand. What is "candidate tree"?

Powerpc or ide git repository for upstream to mainline.
It is odd that patches for one function in different trees.
Thanks.
Roy
