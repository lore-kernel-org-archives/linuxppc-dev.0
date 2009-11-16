Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 2BF21B7BEF
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 21:24:20 +1100 (EST)
Date: Mon, 16 Nov 2009 11:24:14 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] net/can: add driver for mscan family & mpc52xx_mscan
Message-ID: <20091116102414.GB30609@pengutronix.de>
References: <1258128892-28800-1-git-send-email-w.sang@pengutronix.de>
	<4B0110D5.6010405@grandegger.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
In-Reply-To: <4B0110D5.6010405@grandegger.com>
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
	socketcan-core@lists.berlios.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wolfgang,

On Mon, Nov 16, 2009 at 09:44:05AM +0100, Wolfgang Grandegger wrote:
> Hi Wolfram,
>=20
> thanks for pushing this driver to mainline. I think you should also add
> a CC to the Devicetree-discuss ML.

thank you very much for your review! I agree with nearly all of your points=
 and will
send an update today. The only thing I have doubts about is removing those =
lines:

> +MODULE_AUTHOR("Andrey Volkov <avolkov@varma-el.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("CAN port driver for a MSCAN based chips");

I looked around in the kernel sources and found that they are often present=
 in
generic modules, even if they can't be used without a wrapper (examples are=
 all
files in drivers/i2c/algos or drivers/net/wireless/iwlwifi/iwl-core.c). As =
I'm
also a bit anxious to fiddle with other people's authorship, I'd prefer to =
keep
them.

Finally, I'll also try to test suspend/resume, but I have to find out if it=
 is
supported on that board in general.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksBKE4ACgkQD27XaX1/VRtMogCgj132nU0J0Jp3XgwdhUox6ljL
Ii8AnjYgcP1nRMr0ebFSaOh5nbLeoXEM
=GXE/
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
