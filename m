Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
From: Michael Ellerman <michael@ellerman.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20080806060239.30717.79273.stgit@trillian.secretlab.ca>
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060239.30717.79273.stgit@trillian.secretlab.ca>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-U4l+6KO78WBFv0SznHE6"
Date: Wed, 06 Aug 2008 16:14:09 +1000
Message-Id: <1218003249.7893.19.camel@localhost>
Mime-Version: 1.0
Cc: miltonm@bga.com, linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-U4l+6KO78WBFv0SznHE6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-08-06 at 00:02 -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>=20
> of_lookup_stdout() is useful for figuring out what device to use as outpu=
t
> for early boot progress messages.  It returns the node pointed to by the
> linux,stdout-path property in the chosen node.

Nice. You don't feel like converting all the places that currently do it
by hand to use this do you :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-U4l+6KO78WBFv0SznHE6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBImUExdSjSd0sB4dIRAgoaAJsHQ2XuHzs65PycnJ/xsb6P4oYoMgCfTGz+
VCGC2t0UUx2xKvE75ifNtxI=
=zek3
-----END PGP SIGNATURE-----

--=-U4l+6KO78WBFv0SznHE6--
