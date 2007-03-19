Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A5E7DDF83
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 10:46:12 +1100 (EST)
Subject: Re: [PATCH 4/5] powermac: proper sleep management
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20070319105359.744830000@sipsolutions.net>
References: <20070319105352.771599000@sipsolutions.net>
	<20070319105359.744830000@sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ET7lJBi+z1C/kIhLq4Ar"
Date: Tue, 20 Mar 2007 00:44:08 +0100
Message-Id: <1174347848.5707.0.camel@johannes.berg>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ET7lJBi+z1C/kIhLq4Ar
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-03-19 at 11:53 +0100, Johannes Berg wrote:
>=20
> +static struct pm_ops pmu_pm_ops =3D {
> +       .pm_disk_mode =3D PM_DISK_PLATFORM,=20

That shouldn't be there, not sure how it slipped it.

johannes

--=-ET7lJBi+z1C/kIhLq4Ar
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF/yBI/ETPhpq3jKURAupBAJ9woPfpTn/yAsO+Ne3gMLpu7RjjNQCeJKKd
TIpB1MJRw7kF7mEIc0skrls=
=eOoh
-----END PGP SIGNATURE-----

--=-ET7lJBi+z1C/kIhLq4Ar--
