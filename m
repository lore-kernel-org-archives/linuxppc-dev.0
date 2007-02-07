Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 64B73DDE35
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Feb 2007 19:42:10 +1100 (EST)
Date: Wed, 7 Feb 2007 11:42:04 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Jack Ger" <m_123456_h@hotmail.com>
Subject: Re: Problem with linking customer phy with fs_enet drivers
Message-ID: <20070207114204.20adc461@localhost.localdomain>
In-Reply-To: <BAY116-F750CC7583A9FF132FE0E2CD9E0@phx.gbl>
References: <BAY116-F750CC7583A9FF132FE0E2CD9E0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_2D1=K4x+C/rVtWUgiNDm0gV";
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

--Sig_2D1=K4x+C/rVtWUgiNDm0gV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 06 Feb 2007 21:11:15 -0800
Jack Ger wrote:

> Hi Vitaly,
>=20
> Thanks for your response.
>=20
> I dont know how to create the patch which I changed.  I disabled
> all the board_init in mpc885ads_setup.c, and disable the scc and fcc
> driver init function in the fs_enet-main.c init.
>=20
So, you are using board specific file for mpc885ads? what is the
platform info passed into fs_enet then (that is filled in there)?

Note that you have to specify bus_id right way. Also, looks like you do
not have fsl-cpm-fec-mdio device registered on platform bus. fs_enet suppor=
ts=20
fec and bitbang mii types so far, and if you have your LXT970 connected ano=
ther way,
you'll have to implement respective mii driver (like in drivers/net/fs_enet=
/mii-*)

--
Sincerely, Vitaly

--Sig_2D1=K4x+C/rVtWUgiNDm0gV
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFyZDcuOg9JvQhSEsRAgAKAKCHYE1k6/4fEx4uG2XIAe8bbF3gpgCgmE8I
4RWu6eG7E/e5kS4DbwxCnKE=
=EGhJ
-----END PGP SIGNATURE-----

--Sig_2D1=K4x+C/rVtWUgiNDm0gV--
