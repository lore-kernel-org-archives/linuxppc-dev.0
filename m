Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 166CDDDD0A
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 11:05:45 +1100 (EST)
Date: Tue, 27 Nov 2007 11:05:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 2/9] ps3: Use symbolic names for video modes
Message-Id: <20071127110538.32f8dfef.sfr@canb.auug.org.au>
In-Reply-To: <20071126172712.128301000@pademelon.sonytel.be>
References: <20071126172455.308741000@pademelon.sonytel.be>
	<20071126172712.128301000@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__27_Nov_2007_11_05_38_+1100_2OITvKt3g7Xo4vQc"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__27_Nov_2007_11_05_38_+1100_2OITvKt3g7Xo4vQc
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Nov 2007 18:24:57 +0100 Geert Uytterhoeven <Geert.Uytterhoeven@s=
onycom.com> wrote:
>
> @@ -594,20 +594,21 @@ static const struct {
>  	unsigned mask : 19;
>  	unsigned id :  4;
>  } ps3av_preferred_modes[] =3D {
> -	{ .mask =3D PS3AV_RESBIT_WUXGA		<< SHIFT_VESA,	.id =3D 13 },
> -	{ .mask =3D PS3AV_RESBIT_1920x1080P	<< SHIFT_60,	.id =3D 5 },
> -	{ .mask =3D PS3AV_RESBIT_1920x1080P	<< SHIFT_50,	.id =3D 10 },
> -	{ .mask =3D PS3AV_RESBIT_1920x1080I	<< SHIFT_60,	.id =3D 4 },
> -	{ .mask =3D PS3AV_RESBIT_1920x1080I	<< SHIFT_50,	.id =3D 9 },
> -	{ .mask =3D PS3AV_RESBIT_SXGA		<< SHIFT_VESA,	.id =3D 12 },
> -	{ .mask =3D PS3AV_RESBIT_WXGA		<< SHIFT_VESA,	.id =3D 11 },
> -	{ .mask =3D PS3AV_RESBIT_1280x720P	<< SHIFT_60,	.id =3D 3 },
> -	{ .mask =3D PS3AV_RESBIT_1280x720P	<< SHIFT_50,	.id =3D 8 },
> -	{ .mask =3D PS3AV_RESBIT_720x480P		<< SHIFT_60,	.id =3D 2 },
> -	{ .mask =3D PS3AV_RESBIT_720x576P		<< SHIFT_50,	.id =3D 7 },
> +	{ PS3AV_RESBIT_WUXGA      << SHIFT_VESA, PS3AV_MODE_WUXGA   },
> +	{ PS3AV_RESBIT_1920x1080P << SHIFT_60,   PS3AV_MODE_1080P60 },
> +	{ PS3AV_RESBIT_1920x1080P << SHIFT_50,   PS3AV_MODE_1080P50 },
> +	{ PS3AV_RESBIT_1920x1080I << SHIFT_60,   PS3AV_MODE_1080I60 },
> +	{ PS3AV_RESBIT_1920x1080I << SHIFT_50,   PS3AV_MODE_1080I50 },
> +	{ PS3AV_RESBIT_SXGA       << SHIFT_VESA, PS3AV_MODE_SXGA    },
> +	{ PS3AV_RESBIT_WXGA       << SHIFT_VESA, PS3AV_MODE_WXGA    },
> +	{ PS3AV_RESBIT_1280x720P  << SHIFT_60,   PS3AV_MODE_720P60  },
> +	{ PS3AV_RESBIT_1280x720P  << SHIFT_50,   PS3AV_MODE_720P50  },
> +	{ PS3AV_RESBIT_720x480P   << SHIFT_60,   PS3AV_MODE_480P    },
> +	{ PS3AV_RESBIT_720x576P   << SHIFT_50,   PS3AV_MODE_576P    },

Why did you remove the C99 style initialisers?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__27_Nov_2007_11_05_38_+1100_2OITvKt3g7Xo4vQc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHS19WTgG2atn1QN8RAhxjAJwO8pMQu5fv7MzhHK+grvUvE3S7FACfUQMh
H/2Vj3Wuoo0daPBQ+TH9kxc=
=GFUR
-----END PGP SIGNATURE-----

--Signature=_Tue__27_Nov_2007_11_05_38_+1100_2OITvKt3g7Xo4vQc--
