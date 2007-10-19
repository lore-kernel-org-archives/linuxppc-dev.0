Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AB64BDDE36
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 17:31:41 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l9J7VYCd011092
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 00:31:35 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l9J7VXm4021913
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 02:31:34 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v5 9/9] add MPC837x MDS board default device tree
Date: Fri, 19 Oct 2007 15:31:32 +0800
Message-ID: <989B956029373F45A0B8AF0297081890019B5C7A@zch01exm26.fsl.freescale.net>
In-Reply-To: <20071019005613.GA18240@localhost.localdomain>
References: <1192702580-6353-1-git-send-email-leoli@freescale.com>
	<20071019005613.GA18240@localhost.localdomain>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "David Gibson" <david@gibson.dropbear.id.au>,
	"Phillips Kim-R1AAHA" <Kim.Phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: David Gibson [mailto:david@gibson.dropbear.id.au]=20
> Sent: Friday, October 19, 2007 8:56 AM
> To: Li Yang-r58472
> Cc: galak@kernel.crashing.org; paulus@samba.org;=20
> linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH v5 9/9] add MPC837x MDS board default device tree
>=20
> On Thu, Oct 18, 2007 at 06:16:20PM +0800, Li Yang wrote:
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts=20
> > b/arch/powerpc/boot/dts/mpc8377_mds.dts
> > new file mode 100644
> > index 0000000..8530de6
> > --- /dev/null
> > +++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
> > @@ -0,0 +1,282 @@
> [snip]
> > +		crypto@30000 {
> > +			model =3D "SEC3";
> > +			compatible =3D "talitos";
>=20
> That compatible doesn't look specific enough.  It should at=20
> least have a vendor portion.  In general it's best to have=20
> all the information you need to pick a driver and options in=20
> compatible, rather than splitting that info into model.

I think we could do this in a separate patch.  Change the spec and then
update all the in-tree device tree with SEC node.

- Leo
