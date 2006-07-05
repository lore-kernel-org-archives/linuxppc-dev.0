Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id B240567B6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Jul 2006 18:35:55 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k659r3Xn022091
	for <linuxppc-embedded@ozlabs.org>; Wed, 5 Jul 2006 03:53:03 -0600 (MDT)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k658Zp5t016151
	for <linuxppc-embedded@ozlabs.org>; Wed, 5 Jul 2006 03:35:52 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306FFBEDC@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: Laurent Lagrange <lagrange@fr.oleane.com>, pantelis@embeddedalley.com
Subject: RE: Linux 2.6.x  :  cpm_dpalloc alignment bug perhaps not fully r
	esolved
Date: Wed, 5 Jul 2006 16:35:41 +0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Laurent Lagrange [mailto:lagrange@fr.oleane.com]
> Sent: Wednesday, July 05, 2006 4:26 PM
> To: Li Yang-r58472; pantelis@embeddedalley.com
> Cc: linuxppc-embedded@ozlabs.org
> Subject: RE: Linux 2.6.x : cpm_dpalloc alignment bug perhaps not =
fully resolved
>=20
> Hi Leo,
>=20
> Thanks for the reply.
>=20
> The patch, I already applied, comes directly from Pantelis
> and is the same code as found at
> http://patchwork.ozlabs.org/linuxppc/patch?id=3D3484

Sure, it is the patch I mentioned.  Also be noted that the patch only =
fixes rheap in arch/ppc/.  If you are using latest 2.6 source, you are =
most probably using code under arch/powerpc/.
>=20
> What do you mean by the alignment patch ?
>=20
> I suspect a problem in the cpm_dpfree function,
> not in the cpm_dpalloc function.
>=20
> I'll try to give more details.
>=20
> Best regards
> Laurent
>=20
>=20
>=20
> > -----Message d'origine-----
> > De : Li Yang-r58472 [mailto:LeoLi@freescale.com]
> > Envoy=E9 : mer. 5 juillet 2006 03:32
> > =C0 : Laurent Lagrange; pantelis@embeddedalley.com
> > Cc : linuxppc-embedded@ozlabs.org
> > Objet : RE: Linux 2.6.x : cpm_dpalloc alignment bug perhaps not =
fully
> > resolved
> >
> >
> > Did you apply the alignment patch too?  AFAIK, the problem is
> > never fixed in
> > mainstream trees.
> >
> > Best Regards,
> > Leo
> >
