Return-Path: <michael@ellerman.id.au>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
From: Michael Ellerman <michael@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <26babf7b7398794f08e7417377b3facc@kernel.crashing.org>
References: <1175208237.3122.78.camel@pmac.infradead.org>
	<26babf7b7398794f08e7417377b3facc@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-kLtUkX8FVRt1WNc2tPN2"
Date: Mon, 02 Apr 2007 10:20:20 +1000
Message-Id: <1175473220.3144.1.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	cbe-oss-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-kLtUkX8FVRt1WNc2tPN2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-03-30 at 15:25 +0200, Segher Boessenkool wrote:
> > The old 2.6.16 kernel handled memory statically and it was shown in the
> > device tree. The current kernel deals with the hypervisor and hotplugs
> > the memory, so we should just ignore anything that's reported in the
> > device-tree. This enables the current kernel to be booted from 2.6.16
> > without evil hacks in head_64.S to override the device-tree.
>=20
> Surely when you are booted you already have some
> memory plugged for you -- shouldn't that memory be
> in the device tree?

See ps3_mm_init(), called from _probe_.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-kLtUkX8FVRt1WNc2tPN2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBGEExDdSjSd0sB4dIRAuYsAJ9tPZu/ewXxySxD9AgKsIaSDLAy8QCeNejx
uzLiozJ5vKW/Vh/KJfAja7o=
=dvQ6
-----END PGP SIGNATURE-----

--=-kLtUkX8FVRt1WNc2tPN2--
