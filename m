Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id F0183DDF85
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 02:22:31 +1000 (EST)
Date: Wed, 23 Jul 2008 02:22:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: fix struct uart_info change fallout
Message-Id: <20080723022224.22eb4d26.sfr@canb.auug.org.au>
In-Reply-To: <20080722165929.717e38d4@lxorguk.ukuu.org.uk>
References: <20080722102520.ca801ab5.sfr@canb.auug.org.au>
	<20080722025850.0d073a5e@lxorguk.ukuu.org.uk>
	<20080722130152.f115224d.sfr@canb.auug.org.au>
	<20080722114436.2c13edea@lxorguk.ukuu.org.uk>
	<20080723014910.7351c495.sfr@canb.auug.org.au>
	<20080722165929.717e38d4@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__23_Jul_2008_02_22_24_+1000_qbHkhz.t3Qwcr/IY"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__23_Jul_2008_02_22_24_+1000_qbHkhz.t3Qwcr/IY
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan,

On Tue, 22 Jul 2008 16:59:29 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrot=
e:
>
> I really expected to get the rest merged within an hour or two, but then
> it broke, then I was travelling and each time I got wireless access to
> resync the tree and work on it - it broke again and again and again.
>=20
> Next time I will bump the patch up the pile and get it out earlier when
> that occurs.

Excellent.

Just asking: do you have an aversion for merging fixes back into
patches?  Not a problem, just so I know.  Different people work
differently.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__23_Jul_2008_02_22_24_+1000_qbHkhz.t3Qwcr/IY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiGCUAACgkQjjKRsyhoI8yJjQCfQIgDLPPf4zIDg5t2Oy3ZZDC/
/4sAnjv8NSB6qMhjhQN7dWrUXSbG5a9p
=6thl
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Jul_2008_02_22_24_+1000_qbHkhz.t3Qwcr/IY--
