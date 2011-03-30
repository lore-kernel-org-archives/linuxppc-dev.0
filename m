Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82AADB6EEC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Mar 2011 19:05:29 +1100 (EST)
Date: Wed, 30 Mar 2011 10:05:18 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: dtc: remove obsolete .gitignore entries
Message-ID: <20110330080518.GC2232@pengutronix.de>
References: <1299948250-32084-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
In-Reply-To: <1299948250-32084-1-git-send-email-w.sang@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 12, 2011 at 05:44:10PM +0100, Wolfram Sang wrote:
> dtc was moved and .gitignores have been added to the new location. So, we=
 can
> delete the old, forgotten ones.
>=20
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Ping. Is this one more for Ben or more for Grant?

> ---
>  arch/powerpc/boot/.gitignore         |    1 -
>  arch/powerpc/boot/dtc-src/.gitignore |    3 ---
>  2 files changed, 0 insertions(+), 4 deletions(-)
>  delete mode 100644 arch/powerpc/boot/dtc-src/.gitignore
>=20
> diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
> index 3d80c3e..12da77e 100644
> --- a/arch/powerpc/boot/.gitignore
> +++ b/arch/powerpc/boot/.gitignore
> @@ -1,5 +1,4 @@
>  addnote
> -dtc
>  empty.c
>  hack-coff
>  infblock.c
> diff --git a/arch/powerpc/boot/dtc-src/.gitignore b/arch/powerpc/boot/dtc=
-src/.gitignore
> deleted file mode 100644
> index a7c3f94..0000000
> --- a/arch/powerpc/boot/dtc-src/.gitignore
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -dtc-lexer.lex.c
> -dtc-parser.tab.c
> -dtc-parser.tab.h
> --=20
> 1.7.2.3
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2S5D4ACgkQD27XaX1/VRsQawCfUSFa4SWWCdOn1llyn2JQthFn
97QAniRFmS17LMgfCO1XNaG9Bh2JzOJt
=d1oL
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--
