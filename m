Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0A28767B5B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 23 Oct 2006 08:50:17 +1000 (EST)
Date: Mon, 23 Oct 2006 02:50:01 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Norbert van Bolhuis <nvbolhuis@aimsys.nl>
Subject: Re: MPC8xx CPM I2C interface driver
Message-ID: <20061023025001.45e821c3@localhost.localdomain>
In-Reply-To: <452B626D.8050106@aimsys.nl>
References: <452B626D.8050106@aimsys.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_qm.gOoLD9Fyna/NOpySuWSe";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Sig_qm.gOoLD9Fyna/NOpySuWSe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Oct 2006 11:05:49 +0200
Norbert van Bolhuis wrote:

>=20
> Is there no MPC8xx CPM I2C interface driver in (latest) linux v2.6 or
> am I mistaken ?
> There's no code for CONFIG_I2C_ALGO8XX.
The answer is - no, there is no stuff in the 2.6 kernel. I used to have the=
 port from 2.4 a while ago (an=20
improvement to the patches posted here btw)  but had no chance to cleanup i=
t and push through lm_sensors.

>=20
> I've a MPC870 based board and I was hoping for a MPC8xx CPM I2C
> interface driver to be there (allowing user applications to open and
> read/write /dev/i2c-0)
>=20
You should be able to locate sources in this list's archives. Ping me once =
more if not, I'll try to dig it out of my HDD then...

> Thanks,
> N.
>=20
>=20
>=20

--
-Vitaly

--Sig_qm.gOoLD9Fyna/NOpySuWSe
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFO/WauOg9JvQhSEsRArlTAKCk4HOWJETzofK+90Y91ujPmvkj4ACgmFT6
YXZtTxeOQopExhongRBMAxY=
=3qy3
-----END PGP SIGNATURE-----

--Sig_qm.gOoLD9Fyna/NOpySuWSe--
