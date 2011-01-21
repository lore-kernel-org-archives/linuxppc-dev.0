Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8F3D2B70E4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 13:30:45 +1100 (EST)
Date: Fri, 21 Jan 2011 13:30:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: of_flat_dt_match() helper build FAIL
Message-Id: <20110121133039.bc48cef7.sfr@canb.auug.org.au>
In-Reply-To: <1295576122.2148.271.camel@pasglop>
References: <1295576122.2148.271.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__21_Jan_2011_13_30_39_+1100_qr.tJsxEE/Z_0LkM"
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__21_Jan_2011_13_30_39_+1100_qr.tJsxEE/Z_0LkM
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Fri, 21 Jan 2011 13:15:22 +1100 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> a4f740cf33f7f6c164bbde3c0cdbcc77b0c4997c introduces:
>=20
> /arch/powerpc/platforms/83xx/mpc831x_rdb.c:63: error: expected '{'
> before 'const'
>=20
>  and more...
>=20
> This hunk is obviously bogus:
>=20
> +struct const char *board[] __initdata =3D {
> +	"MPC8313ERDB",
> +	"fsl,mpc8315erdb",
> +	NULL
> +}
> +
>=20
> You should at least compile test your changes :-(
>=20
> Please send Linus a fix.

Its already in Grant's devicetree/merge branch (which I assume he will
ask you to pull soon) and has been in linux-next for the past 2 days.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__21_Jan_2011_13_30_39_+1100_qr.tJsxEE/Z_0LkM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJNOO/PAAoJEDMEi1NhKgbsrD4H/09u10zXh6xDgqLdCmavS65R
QwHSrrBraD/2OIIJVj4EiI87Jqbg3Ev9fE2GNk/dw6vKTmvaph+Zjhds1Ds5Ehbp
ZqJpiX/N9BAVkM3MYQpauhcx1h243UVtex9d+kcbV3qFuCteMl0gTQNM5bJSwdD0
m+kqYnrbMc1+lBYSnYIFk8NGPoZAieEq8h4HshKnyMLOvJ9paT94Vkq4nr6nY4AB
nRP18Xz7XcfbsokLbW/dHZvb1sEs/jwOPc7x2EYVKX3MmcRZVsE+T+TkrhoZNchx
r990XZpojNzmcGs/O27cNDfGz5j9y9usC219X0O8HAiwTK5Ru1OQ7RU5puDdQjw=
=HzPT
-----END PGP SIGNATURE-----

--Signature=_Fri__21_Jan_2011_13_30_39_+1100_qr.tJsxEE/Z_0LkM--
