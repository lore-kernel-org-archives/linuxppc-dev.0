Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2A866B70A4
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Dec 2010 18:27:19 +1100 (EST)
Date: Wed, 8 Dec 2010 18:27:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Hardcode popcnt instructions for old assemblers
Message-Id: <20101208182712.1c9ddafa.sfr@canb.auug.org.au>
In-Reply-To: <20101208165817.0df89814@kryten>
References: <20101208165817.0df89814@kryten>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__8_Dec_2010_18_27_12_+1100_04+fi5l=lC3BtLbH"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__8_Dec_2010_18_27_12_+1100_04+fi5l=lC3BtLbH
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Wed, 8 Dec 2010 16:58:17 +1100 Anton Blanchard <anton@samba.org> wrote:
>
> The popcnt instructions went into binutils relatively recently. As with a
> number of other instructions, create macros and hardcode them.
>=20
> Signed-off-by: Anton Blanchard <anton@samba.org>

That certainly fixes the build issue for me (tested ppc64_defconfig with
binutils 2.19.1).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__8_Dec_2010_18_27_12_+1100_04+fi5l=lC3BtLbH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJM/zNQAAoJEDMEi1NhKgbsnbgIAIalPYKqm+ARtVU8pcnrMbCi
XruC481K8s03Am5AwMrRldCBLzt4U8fK8PhNJEgRqUz15NSB16bqlNOm9cx2g8w8
XT6WtY+adeEMScN3+iAOHo1JsBJ4C2rMi5CK8xpnu+hX39SniyICragUC9KtT4z1
sxKzV9kFEVBzGpJsCL6ChmV4w19BhK69RR0c/kIuv3OSsNmq/aodkq8p1bM6700u
rcclbLozozKjg/fPykHAgxUtG4SyjZ+2xTFDSj9lUonmvrUPVCVunzAyZyo3N6wQ
hX6Izgm1MFGBm4O8wG7Ha5L2fld9GucBq38979Rcq/yXX9vjZgLyTUEOqU+xx5g=
=Kp4/
-----END PGP SIGNATURE-----

--Signature=_Wed__8_Dec_2010_18_27_12_+1100_04+fi5l=lC3BtLbH--
