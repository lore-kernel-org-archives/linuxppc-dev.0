Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E5456DDDF3
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 11:21:14 +1100 (EST)
Date: Sat, 22 Dec 2007 11:21:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 17/21] [POWERPC] Base support for 440SPe "Katmai" eval
	board
Message-Id: <20071222112105.b24c85c5.sfr@canb.auug.org.au>
In-Reply-To: <20071221043938.9C15EDDFBF@ozlabs.org>
References: <20071221043938.9C15EDDFBF@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__22_Dec_2007_11_21_05_+1100_ViufK9_VcvxGfvKW"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__22_Dec_2007_11_21_05_+1100_ViufK9_VcvxGfvKW
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Dec 2007 15:39:34 +1100 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> +++ linux-merge/arch/powerpc/platforms/44x/katmai.c	2007-12-21 14:34:33.0=
00000000 +1100
> +
> +static struct of_device_id katmai_of_bus[] =3D {

__initdata (preferably) or const, please.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__22_Dec_2007_11_21_05_+1100_ViufK9_VcvxGfvKW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHbFh6TgG2atn1QN8RAhmXAJ9DSM0yBIV6k4HBrvvzAVujQmHfZwCfc/1C
LkSzSh9S0RDnuTcoQVVcbAM=
=aNjy
-----END PGP SIGNATURE-----

--Signature=_Sat__22_Dec_2007_11_21_05_+1100_ViufK9_VcvxGfvKW--
