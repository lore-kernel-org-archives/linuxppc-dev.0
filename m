Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CF90BB7D11
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Apr 2010 09:14:33 +1100 (EST)
Date: Fri, 2 Apr 2010 00:14:27 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: ST <st@iss.tu-darmstadt.de>
Subject: Re: dts,i2c,pcf8574 on Xilinx XUP
Message-ID: <20100401221427.GA13989@pengutronix.de>
References: <201004012250.33877.st@iss.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
In-Reply-To: <201004012250.33877.st@iss.tu-darmstadt.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 01, 2010 at 10:50:33PM +0200, ST wrote:

> Unfortunatly the i2c driver hangs the git://git.xilinx.com/linux-2.6-xlnx
> tree hard if i run i2cdetect. Also my pcf device is not listed as a devic=
e.

Is there any output before the crash? Also, the complete device tree and
bootlog may be useful.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAku1GsMACgkQD27XaX1/VRvdMACgm+O6778nR4BWOj2aLycFVNq5
6fEAoMkwtnITD/uCI/boB5TDiENLK0B4
=LClU
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
