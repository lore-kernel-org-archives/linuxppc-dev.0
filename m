Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Make #include <sysdev/foo.h> work for 64-bit powerpc
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <0A4216BD-1505-46DE-B08E-23E9B7E51AD2@kernel.crashing.org>
References: <be85035fa2cb015a8020e63b40c6d5375aaff866.1207031915.git.michael@ellerman.id.au>
	<20080401175442.bf0d0c34.sfr@canb.auug.org.au>
	<0A4216BD-1505-46DE-B08E-23E9B7E51AD2@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-j55PlcjLEJ5ZXeGf559Z"
Date: Wed, 02 Apr 2008 12:55:54 +1100
Message-Id: <1207101354.7349.0.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-j55PlcjLEJ5ZXeGf559Z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Tue, 2008-04-01 at 08:18 -0500, Kumar Gala wrote:
> On Apr 1, 2008, at 1:54 AM, Stephen Rothwell wrote:
> > Hi Michael,
> >
> > On Tue,  1 Apr 2008 17:39:11 +1100 (EST) Michael Ellerman <michael@elle=
rman.id.au=20
> > > wrote:
> >>
> >> We currently have inconsistent settings between 32 & 64-bit which =20
> >> means
> >> 32-bit code can #include <sysdev/foo.h> but 64-bit code can't.
> >
> > Kumar sent a very similar (if not identical) patch earlier today.
>=20
> I actually sent it several days ago, but reposted as part of the =20
> series of work I was doing. ;)

OK, I missed it. I'm not fussed who's goes in, I just needed it for some
other work.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-j55PlcjLEJ5ZXeGf559Z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH8ueqdSjSd0sB4dIRAqohAJ0WVhgQ1Y+4sn0066Qz2jbMuDLFLQCgjnDc
9VJ7UQZy8TF++aG5i/s4qcA=
=Afou
-----END PGP SIGNATURE-----

--=-j55PlcjLEJ5ZXeGf559Z--
