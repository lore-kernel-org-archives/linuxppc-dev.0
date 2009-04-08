Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 418EADE09E
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 10:52:37 +1000 (EST)
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
From: Michael Ellerman <michael@ellerman.id.au>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <ed82fe3e0904071736w55dff582y8ac2681f6410865b@mail.gmail.com>
References: <49DB6914.1030107@freescale.com> <49DBE858.9040004@kernel.org>
	<ed82fe3e0904071736w55dff582y8ac2681f6410865b@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-b28A0KydJshxhCxHK37g"
Date: Wed, 08 Apr 2009 10:52:36 +1000
Message-Id: <1239151956.10104.1.camel@localhost>
Mime-Version: 1.0
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>,
	Linux PPC Development <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-b28A0KydJshxhCxHK37g
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-04-07 at 19:36 -0500, Timur Tabi wrote:
> On Tue, Apr 7, 2009 at 6:57 PM, Tejun Heo <tj@kernel.org> wrote:
>=20
> > Hmmm... that means intx isn't set by default.  I'm not sure what is
> > the right thing to do here.  I think it's something which should be
> > handled by the PCI layer.  Oh well, maybe we should just revert the
> > change and keep setting intx?
>=20
> cc'ing linuxppc-dev
>=20
> I really don't know what should be done.  It seems to make sense to
> have the PCI layer enable interrupts.
>=20
> This seems to be a powerpc-specific bug, but I don't know enough of
> the PCI subsystem.

Can you post some more details, or point us at a thread?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-b28A0KydJshxhCxHK37g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknb9VQACgkQdSjSd0sB4dLKaACghkUDCnVPPYcb2zjhFSD3ACBl
6JwAniHNg/U2lPh7hSLghAuGaZIfJIHw
=AoRc
-----END PGP SIGNATURE-----

--=-b28A0KydJshxhCxHK37g--
