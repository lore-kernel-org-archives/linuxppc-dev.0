Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9961EB6F7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 01:11:54 +1000 (EST)
Message-ID: <4E414E2F.8070404@pengutronix.de>
Date: Tue, 09 Aug 2011 17:11:43 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
Subject: Re: [PATCH 4/4] [powerpc] Add flexcan device support for p1010rdb.
References: <1312892907-20419-1-git-send-email-holt@sgi.com>	<1312892907-20419-5-git-send-email-holt@sgi.com>	<9C64B7751C3BCA41B64A68E23005A7BE1C4A88@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110809145507.GY4926@sgi.com>
In-Reply-To: <20110809145507.GY4926@sgi.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEBA8B0D708A80315153BC444"
Cc: "socketcan-core@lists.berlios.de" <socketcan-core@lists.berlios.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	U Bhaskar-B22300 <B22300@freescale.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEBA8B0D708A80315153BC444
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/09/2011 04:55 PM, Robin Holt wrote:
> On Tue, Aug 09, 2011 at 02:45:58PM +0000, U Bhaskar-B22300 wrote:
>> Hi Robin,
>> 	Where are you doing the irq handling ie request_irq() for the powerpc=
 based P1010.
>> 	Or the existing code of ARM based FlexCAN will work for P1010 ??
>=20
> It appears that the of_device stuff got moved under the struct device
> and that allows the request_irq() to just magically work.

cool :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigEBA8B0D708A80315153BC444
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5BTjIACgkQjTAFq1RaXHM10QCeNMUSvZnJD1ArKUcgSkshJmV+
foUAnRXxrmIgEKH0rDB45RXtoJMCcqlX
=9o+u
-----END PGP SIGNATURE-----

--------------enigEBA8B0D708A80315153BC444--
