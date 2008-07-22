Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2DAA0DDFAE
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 01:49:17 +1000 (EST)
Date: Wed, 23 Jul 2008 01:49:10 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: fix struct uart_info change fallout
Message-Id: <20080723014910.7351c495.sfr@canb.auug.org.au>
In-Reply-To: <20080722114436.2c13edea@lxorguk.ukuu.org.uk>
References: <20080722102520.ca801ab5.sfr@canb.auug.org.au>
	<20080722025850.0d073a5e@lxorguk.ukuu.org.uk>
	<20080722130152.f115224d.sfr@canb.auug.org.au>
	<20080722114436.2c13edea@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__23_Jul_2008_01_49_10_+1000_54=MKzBin+g38X6A"
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

--Signature=_Wed__23_Jul_2008_01_49_10_+1000_54=MKzBin+g38X6A
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan,

On Tue, 22 Jul 2008 11:44:36 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrot=
e:
>
> > What is your problem with the linux-next tree.  The problem was
> > discovered and reported when I first merged the ttydev tree into
> > linux-next on July 1.  The fixes were in linux-next on July 2.
>=20
> Yes .. and ? The clashes kept happening despite that when I was doing the
> merges (and going on holiday for a week and trying to sort it out with
> limited time and internet access)
>=20
> Sorry I don't follow your line of discussion at all here ?

I interpreted your "So much for the linux-next tree" as saying "well,
that has been no help".  I am sorry if I got that wrong.

But my point above is that you had a fix for the current breakage in
Linus' tree a couple of weeks before you sent the patches to Linus that
broke the powerpc build (i.e. linux-next did its job) and yet you didn't
combine the fix with the original patch or send the fix with the original
patch.  So we end up with a powerpc tree that won't build in the middle
of the merge window while more powerpc patches are trying to be
tested ... I understand that this could easily happen because of
forgetfulness, tiredness or accident.

More care was needed.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__23_Jul_2008_01_49_10_+1000_54=MKzBin+g38X6A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiGAXYACgkQjjKRsyhoI8wlkQCeJQjD+tiLvZtl3N47Jnq9NjuV
XzYAn2QGiZJ4gKDb9TxyvdB8Ij7QtzfT
=XP8y
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Jul_2008_01_49_10_+1000_54=MKzBin+g38X6A--
