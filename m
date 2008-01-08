Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B19DDDDEA0
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 14:32:59 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	m083Wg5f021271
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 20:32:43 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m083WfhN022436
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 21:32:42 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 3/3] USB device tree cleanups
Date: Tue, 8 Jan 2008 11:32:39 +0800
Message-ID: <989B956029373F45A0B8AF029708189001BA007C@zch01exm26.fsl.freescale.net>
In-Reply-To: <20080108101028.db21d18a.sfr@canb.auug.org.au>
References: <1199707400-23588-1-git-send-email-leoli@freescale.com><1199707400-23588-2-git-send-email-leoli@freescale.com><1199707400-23588-3-git-send-email-leoli@freescale.com>
	<20080108101028.db21d18a.sfr@canb.auug.org.au>
From: "Li Yang" <LeoLi@freescale.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Stephen Rothwell
> Sent: Tuesday, January 08, 2008 7:10 AM
> To: Li Yang
> Cc: linuxppc-dev@ozlabs.org; paulus@samba.org
> Subject: Re: [PATCH 3/3] USB device tree cleanups
>=20
> On Mon,  7 Jan 2008 20:03:20 +0800 Li Yang=20
> <leoli@freescale.com> wrote:
> >
> > +++ b/arch/powerpc/sysdev/fsl_soc.c
> > @@ -533,9 +533,7 @@ static int __init fsl_usb_of_init(void)
> >  		*usb_dev_dr_client =3D NULL;
> >  	int ret;
> > =20
> > -	for (np =3D NULL, i =3D 0;
> > -	     (np =3D of_find_compatible_node(np, "usb",=20
> "fsl-usb2-mph")) !=3D NULL;
> > -	     i++) {
> > +	for_each_compatible_node(np, NULL, "fsl-usb2-mph") {
>=20
> 'i' is no longer being updated (or indeed set to anything)=20
> but is still used in the loop - at least in Paulus' current tree).

Good catch. My careless mistake.  Thanks.

- Leo
