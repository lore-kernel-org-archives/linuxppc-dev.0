Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 36E07B7B9C
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Oct 2009 20:53:47 +1100 (EST)
Date: Mon, 5 Oct 2009 11:53:40 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2] mpc5200: support for the MAN mpc5200 based board uc101
Message-ID: <20091005095340.GA3890@pengutronix.de>
References: <4AADF93C.3030604@denx.de> <20090914080322.GA3164@pengutronix.de>
	<fa686aa40909140745u2cf1dba7q8ae2af53c87bd216@mail.gmail.com>
	<4AC9A463.1080903@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
In-Reply-To: <4AC9A463.1080903@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2009 at 09:46:43AM +0200, Heiko Schocher wrote:

> - serial Console on PSC1
> - 64MB SDRAM
> - MTD CFI Flash
> - Ethernet FEC
> - IDE support
>=20
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> - based on:
>   git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git next
>=20
> - checked with:
> $ ./scripts/checkpatch.pl 0001-mpc5200-support-for-the-MAN-mpc5200-based-=
board-uc1.patch
> total: 0 errors, 0 warnings, 324 lines checked
>=20
> 0001-mpc5200-support-for-the-MAN-mpc5200-based-board-uc1.patch has no obv=
ious style problems and is ready for submission.
> $
>=20
> changes since v1:
>=20
> - add comments from Grant Likely <grant.likely@secretlab.ca>
>   use mpc5200_defconfig as default configuration
> - add comments from Wolfram Sang <w.sang@pengutronix.de>
> - rebase against current next
>=20
>  arch/powerpc/boot/dts/uc101.dts              |  317 ++++++++++++++++++++=
++++++
>  arch/powerpc/platforms/52xx/mpc5200_simple.c |    1 +
>  2 files changed, 318 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/uc101.dts
>=20
[...]
> +		wdt {
> +			compatible =3D "generic,gpio-wdt";
> +			reg =3D <0x600 0x10>;
> +			gpios =3D <&gpt0 0 0>;
> +			period =3D <500>;	// WDT trigger period in msec
> +		};

Is this an official binding? I also did an gpio-watchdog a while ago and th=
ere
were some issues with the binding, IIRC. Would be nice if this has been sol=
ved
meanwhile.

Other than that, it looks okay to me.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrJwiQACgkQD27XaX1/VRsb/wCaA/nafNcKz0sKQwSHJm3WyzPO
w7gAoJ/2ROfVM1PUfbIwlpEqYoEYluEm
=cE4s
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
