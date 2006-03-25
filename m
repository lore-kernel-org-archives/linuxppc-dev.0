Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 44E0367A65
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2006 18:05:51 +1100 (EST)
Date: Sat, 25 Mar 2006 18:05:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: legacy_serial loop cleanup
Message-Id: <20060325180535.0a680b4d.sfr@canb.auug.org.au>
In-Reply-To: <20060325044501.D32A267A58@ozlabs.org>
References: <20060324041727.F131267B56@ozlabs.org>
	<200603241226.13171.hollis@penguinppc.org>
	<20060325044501.D32A267A58@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__25_Mar_2006_18_05_35_+1100_s8Fi_4Ogn7aBs0az"
Cc: michael@ellerman.id.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__25_Mar_2006_18_05_35_+1100_s8Fi_4Ogn7aBs0az
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 25 Mar 2006 15:45:11 +1100 Michael Neuling <mikey@neuling.org> wrot=
e:
>
> Agreed.  Updated patch below.
>	.
>	.
> +static void __init setup_legacy_serial_console(int console)
> +{
> +	struct legacy_serial_info *info =3D
> +		&legacy_serial_infos[legacy_serial_console];

Except that you don't want to do that ^  (assuming you meant "console")

> +	void __iomem *addr;
> +
> +	if (console < 0)
> +		return;

before this ^ ...   :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__25_Mar_2006_18_05_35_+1100_s8Fi_4Ogn7aBs0az
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEJOvJFdBgD/zoJvwRAsSdAJ9HVAyhirmXaEyvlMv8fUPqiDiHxACbBUBn
25ztiUP7c94ccmBkGkZzpCU=
=ik2u
-----END PGP SIGNATURE-----

--Signature=_Sat__25_Mar_2006_18_05_35_+1100_s8Fi_4Ogn7aBs0az--
