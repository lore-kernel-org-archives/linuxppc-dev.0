Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 56B4EDDD07
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 18:53:00 +1000 (EST)
Subject: Re: [PATCH 7/7] MPIC U3/U4 MSI backend
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <20070508025843.0D93ADDEFD@ozlabs.org>
References: <20070508025843.0D93ADDEFD@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-qAbTJPVTi6ztiVP7HKTx"
Date: Tue, 08 May 2007 10:55:02 +0200
Message-Id: <1178614502.18162.34.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-qAbTJPVTi6ztiVP7HKTx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-05-08 at 12:58 +1000, Michael Ellerman wrote:
> MPIC U3/U4 MSI backend. Based on code from Segher, heavily hacked by me.
> This only deals with MSI on U3/U4 MPICs, aka. CPC 9x5.
>=20
> If we find a U3/U4 then we enable this backend, ie. take over the ppc_md
> MSI hooks. We might need more elaborate logic in future to decide which
> backend is enabled.
>=20
> We need our own irq_chip so that we can do MSI masking/unmasking on
> the device itself. We also need to mask explicitly on shutdown to make
> sure we don't get bitten by lazy-disable semantics.

How badly will this clash with my patch that implements suspend/resume
for mpic, and will I need to do more suspend/resume for this?

johannes

--=-qAbTJPVTi6ztiVP7HKTx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGQDrm/ETPhpq3jKURAnJxAKCSHU8tMT0cZJdL0LN/EOMTQIs3pQCfWvot
uHXScOEEOehw6mnMXV+lVq8=
=yygw
-----END PGP SIGNATURE-----

--=-qAbTJPVTi6ztiVP7HKTx--
