Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2DA73B6F98
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Aug 2011 23:09:37 +1000 (EST)
Message-ID: <4E413186.1010708@pengutronix.de>
Date: Tue, 09 Aug 2011 15:09:26 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
Subject: Re: [RFC 4/4] [powerpc] Add flexcan device support for p1010rdb.
References: <1312869313-22434-1-git-send-email-holt@sgi.com>
	<1312869313-22434-5-git-send-email-holt@sgi.com>
	<4E41291B.3020001@pengutronix.de> <20110809124042.GR4926@sgi.com>
In-Reply-To: <20110809124042.GR4926@sgi.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig617B6AA3EDD354988573323D"
Cc: socketcan-core@lists.berlios.de, netdev@vger.kernel.org,
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
--------------enig617B6AA3EDD354988573323D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/09/2011 02:40 PM, Robin Holt wrote:
> On Tue, Aug 09, 2011 at 02:33:31PM +0200, Marc Kleine-Budde wrote:
>> On 08/09/2011 07:55 AM, Robin Holt wrote:
>>> I added a clock source for the p1010rdb so the flexcan driver
>>> could find its clock frequency.
>>>
>>> Signed-off-by: Robin Holt <holt@sgi.com>
>>> To: Marc Kleine-Budde <mkl@pengutronix.de>,
>>> To: Wolfgang Grandegger <wg@grandegger.com>,
>>> To: U Bhaskar-B22300 <B22300@freescale.com>
>>> Cc: socketcan-core@lists.berlios.de,
>>> Cc: netdev@vger.kernel.org,
>>> Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
>>
>> After fixing Wolfgangs remarks add by Acked-by, for what it's worth in=

>> the ppc-world :)
>=20
> Does that go for the other two patches in the series you have not
> commented on in many revs as well?

They look pretty good so far! I'll compile the next round on arm and
hopefully find time to test on HW.

cheers, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig617B6AA3EDD354988573323D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5BMYkACgkQjTAFq1RaXHM5wACfVsXVhw3mrK+pa1cXW6DN2J7Q
uIcAn2r0GGrsiTy0uW8CKTDwAW7cLb+H
=e0En
-----END PGP SIGNATURE-----

--------------enig617B6AA3EDD354988573323D--
