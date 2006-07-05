Return-Path: <pantelis@embeddedalley.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id 20A0367B5B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Jul 2006 19:43:36 +1000 (EST)
From: Pantelis Antoniou <pantelis@embeddedalley.com>
To: "Laurent Lagrange" <lagrange@fr.oleane.com>
Subject: Re: Linux 2.6.x : cpm_dpalloc alignment bug perhaps not fully resolved
Date: Wed, 5 Jul 2006 12:38:17 +0300
References: <000001c6a013$0f321100$5201a8c0@GEG2400>
In-Reply-To: <000001c6a013$0f321100$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607051238.18237.pantelis@embeddedalley.com>
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

On Wednesday 05 July 2006 12:11, Laurent Lagrange wrote:
>=20
> > -----Message d'origine-----
> > De : Li Yang-r58472 [mailto:LeoLi@freescale.com]
> > Envoy=E9 : mer. 5 juillet 2006 09:36
> > =C0 : Laurent Lagrange; pantelis@embeddedalley.com
> > >
> > > The patch, I already applied, comes directly from Pantelis
> > > and is the same code as found at
> > > http://patchwork.ozlabs.org/linuxppc/patch?id=3D3484
> >
> > Sure, it is the patch I mentioned.  Also be noted that the
> > patch only fixes rheap in arch/ppc/.  If you are using latest
> > 2.6 source, you are most probably using code under arch/powerpc/.
> > >
> I use a Linux 2.6.9 for MPC8260 and the arch/ppc/lib/rheap.c file.
> I have no arch/powerpc tree in this kernel.
>=20
> Before applying the patch, I was not able to get a right aligned area
> with cpm_dpalloc. After applying it, cpm_dpalloc seems to be right
> until I use cpm_dpfree and then cpm_dpalloc on the same area.
>=20
> Another idea ?
> Thanks
> Laurent
>=20
>=20
>=20

Should be a bug at the free. I'll take a look at it when I have a few
spare cycles.

Pantelis
