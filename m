Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E882ADDF3D
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 02:18:46 +1100 (EST)
Subject: Re: [PATCH 4/5] powermac: proper sleep management
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1174315836.5044.10.camel@localhost.localdomain>
References: <20070319105352.771599000@sipsolutions.net>
	<20070319105359.744830000@sipsolutions.net>
	<1174315836.5044.10.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-iaRvFUF6TCd/8PjdHUp5"
Date: Mon, 19 Mar 2007 16:16:42 +0100
Message-Id: <1174317402.22561.0.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-iaRvFUF6TCd/8PjdHUp5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-03-19 at 15:50 +0100, Benjamin Herrenschmidt wrote:
> > This updated version removes the sys_sync() call that can't be done wit=
h
> > processes frozen.
>=20
> Is the generic code still sync'ing beforehand ?

Yes, Rafael told me that the generic code syncs right before freezing
processes.

johannes

--=-iaRvFUF6TCd/8PjdHUp5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF/qla/ETPhpq3jKURAqn/AJ49AQhYFpbhuYG9fhs5tnqKtDvvgQCdEVC/
/tyPk5pOdWCVvCDSlTvaewk=
=ItZy
-----END PGP SIGNATURE-----

--=-iaRvFUF6TCd/8PjdHUp5--
