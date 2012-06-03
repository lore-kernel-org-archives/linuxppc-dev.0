Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 613CFB7037
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Jun 2012 15:30:57 +1000 (EST)
Date: Sun, 3 Jun 2012 15:30:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Fix size of st_nlink on 64bit
Message-Id: <20120603153054.336bf492346c51e4ecbc33af@canb.auug.org.au>
In-Reply-To: <20120603134836.4ffbd73d@kryten>
References: <20120602213452.66ba4cbb@kryten>
 <20120603122850.3c5142767e429f34eb8a921e@canb.auug.org.au>
 <20120603134836.4ffbd73d@kryten>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Sun__3_Jun_2012_15_30_54_+1000_NlZWqCyWpJKIJ_l="
Cc: michael@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 viro@zeniv.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Sun__3_Jun_2012_15_30_54_+1000_NlZWqCyWpJKIJ_l=
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Sun, 3 Jun 2012 13:48:36 +1000 Anton Blanchard <anton@samba.org> wrote:
>
> > > commit e57f93cc53b7 (powerpc: get rid of nlink_t uses, switch to
> > > explicitly-sized type) changed the size of st_nlink on ppc64 from
> > > a long to a short, resulting in boot failures.
> > >=20
> > > Signed-off-by: Anton Blanchard <anton@samba.org>
> >=20
> > Would this affect my (early user mode) boot problems reported
> > yesterday;
> >=20
> > /init: 71: mknod: Permission denied
> > /init: 88: mknod: Permission denied
> > /init: 88: mknod: Permission denied
>=20
> Very similar to the errors I was seeing so I think the patch will fix
> it.

Great.  One less thing to bisect tomorrow :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Sun__3_Jun_2012_15_30_54_+1000_NlZWqCyWpJKIJ_l=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPyvaOAAoJEECxmPOUX5FECrwP/1ElGFRTGOadPb/tfBblbfXl
EC7PMUcEFM9CivyjR7Bu0trDs6qsnifDJay8r2LlQxeIVAeq4/lPRuKX+B2zHwjP
mw+DjUr4ndoa6xntWbsLZktKmvi4furVv3h5dPc92mRaNKtez8ltX70ah8SDWjdV
enGEKnNHxbwVD4qr7Z0Utyj7qr/W2ah6k/F4thfCJyzwKyv/3omq72QXPlZWCHWL
1c+xiu900ve1qQ6CT9L2uM7ewTaxgphQWuonLFIFqj11ADuNLeLEm3LhCGsbF743
vU5mpk2m2qoLhKgrtkyD2JtjXWmn1X79OXQkzFgUd9MXH8y4n3esqvdwAvW+VKor
JAljzSMX9KJNu6ThE9G/8Ydwrr17n5midGJwAftb3XW/B4AbvZ269VzXbyYY3Lm9
GWUXwNgv0fuFY05quBewwfnZt7qsA9PzbJ5lhzw0gKe2K0vUNiaXOIGGorPI0+jq
Xyst/26clgio8CYLmkz5jnCRqnIwmyt38b6VbNyhOBCJ9JbLWJJHrESGbofbud1T
KSyp8TdxoFJhpXAX6HNynQVG0q90I4r4o5ves9yyT9qS21zquFzLAzsJdCL2ugzb
0XV0N2dLZfv1HzxWJlbInWjP4txaZlkLPo2GQwDC/SNwnWhgV3gRKtKdTyLWs3Xx
NOREtNlhj+B1ewvN1AJd
=QZK1
-----END PGP SIGNATURE-----

--Signature=_Sun__3_Jun_2012_15_30_54_+1000_NlZWqCyWpJKIJ_l=--
