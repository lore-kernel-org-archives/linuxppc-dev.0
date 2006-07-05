Return-Path: <lagrange@fr.oleane.com>
Received: from smtp4.clb.oleane.net (smtp4.clb.oleane.net [213.56.31.20])
	by ozlabs.org (Postfix) with ESMTP id 3370E67B80
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Jul 2006 19:10:39 +1000 (EST)
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: "'Li Yang-r58472'" <LeoLi@freescale.com>, <pantelis@embeddedalley.com>
Subject: RE: Linux 2.6.x : cpm_dpalloc alignment bug perhaps not fully resolved
Date: Wed, 5 Jul 2006 11:11:41 +0200
Message-ID: <000001c6a013$0f321100$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306FFBEDC@zch01exm40.ap.freescale.net>
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



> -----Message d'origine-----
> De : Li Yang-r58472 [mailto:LeoLi@freescale.com]
> Envoyé : mer. 5 juillet 2006 09:36
> À : Laurent Lagrange; pantelis@embeddedalley.com
> >
> > The patch, I already applied, comes directly from Pantelis
> > and is the same code as found at
> > http://patchwork.ozlabs.org/linuxppc/patch?id=3484
>
> Sure, it is the patch I mentioned.  Also be noted that the
> patch only fixes rheap in arch/ppc/.  If you are using latest
> 2.6 source, you are most probably using code under arch/powerpc/.
> >
I use a Linux 2.6.9 for MPC8260 and the arch/ppc/lib/rheap.c file.
I have no arch/powerpc tree in this kernel.

Before applying the patch, I was not able to get a right aligned area
with cpm_dpalloc. After applying it, cpm_dpalloc seems to be right
until I use cpm_dpfree and then cpm_dpalloc on the same area.

Another idea ?
Thanks
Laurent
