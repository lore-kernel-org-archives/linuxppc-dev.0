Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2E120DE098
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 02:44:52 +1100 (EST)
Date: Tue, 5 Feb 2008 02:10:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] powerpc: free_property() mustn't be __init
Message-Id: <20080205021005.6bbf8559.sfr@canb.auug.org.au>
In-Reply-To: <20080130200313.GG29368@does.not.exist>
References: <20080130200313.GG29368@does.not.exist>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__5_Feb_2008_02_10_05_+1100_ElOxRJDe4UQZi5f9"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__5_Feb_2008_02_10_05_+1100_ElOxRJDe4UQZi5f9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Jan 2008 22:03:13 +0200 Adrian Bunk <bunk@kernel.org> wrote:
>
> This patch fixes the following section mismatch:
>=20
> <--  snip  -->
>=20
> ...
> WARNING: vmlinux.o(.text+0x55648): Section mismatch in reference from the=
 function .free_node() to the function .init.text:.free_property()
> ...
>=20
> <--  snip  -->
>=20
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__5_Feb_2008_02_10_05_+1100_ElOxRJDe4UQZi5f9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHpyrTTgG2atn1QN8RAoVwAKCVJpcm9sf2B/ydDvczvOYQNQhitgCgir4X
gakVv7jd7vpG9GRDA9dSkZc=
=n0eB
-----END PGP SIGNATURE-----

--Signature=_Tue__5_Feb_2008_02_10_05_+1100_ElOxRJDe4UQZi5f9--
