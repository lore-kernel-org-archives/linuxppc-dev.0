Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3D16EDDDEE
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 17:17:13 +1100 (EST)
Date: Wed, 18 Feb 2009 17:16:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: setup_64.c:450: warning: format '%lx' expects type 'long
	unsigned int'
Message-Id: <20090218171657.0cf35552.sfr@canb.auug.org.au>
In-Reply-To: <1234937030.14060.442.camel@pasglop>
References: <alpine.LRH.2.00.0902171418050.8852@vixen.sonytel.be>
	<1234937030.14060.442.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__18_Feb_2009_17_16_57_+1100_AytTbQzDgw/fGG2x"
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux/PPC,
	Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__18_Feb_2009_17_16_57_+1100_AytTbQzDgw/fGG2x
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Feb 2009 17:03:50 +1100 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> On Tue, 2009-02-17 at 14:21 +0100, Geert Uytterhoeven wrote:
> > and ASM_CONST() appends "UL" to the constant.
> >=20
> We probably want to add a ASM_ULL_CONST() for that...

Except physaddr_t is sometimes 32 bits and sometime 64 bits in the 32 bit
kernel ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__18_Feb_2009_17_16_57_+1100_AytTbQzDgw/fGG2x
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmbp9kACgkQjjKRsyhoI8zhhQCfYA90mDejdL79b816fWcdbl8a
74YAn1xBNvO8jBDx5pgmSf0fiGZZwjFG
=pWwV
-----END PGP SIGNATURE-----

--Signature=_Wed__18_Feb_2009_17_16_57_+1100_AytTbQzDgw/fGG2x--
