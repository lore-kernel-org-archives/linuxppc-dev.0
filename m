Return-Path: <michael@ellerman.id.au>
Subject: Re: [patch 5/5] PS3: Update ps3_defconfig
From: Michael Ellerman <michael@ellerman.id.au>
To: Marvin <marvin24@gmx.de>
In-Reply-To: <200805061014.16229.marvin24@gmx.de>
References: <20080430215644.655638516@am.sony.com>
	<200805021545.01676.marvin24@gmx.de> <481F595F.2090407@am.sony.com>
	<200805061014.16229.marvin24@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/FjtJNYTTGXeiJHBV62H"
Date: Tue, 06 May 2008 20:51:45 +1000
Message-Id: <1210071105.7445.2.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/FjtJNYTTGXeiJHBV62H
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-05-06 at 10:14 +0200, Marvin wrote:
> Hi Geoff,
>=20
> On Monday 05 May 2008 21:00:47 you wrote:
> > Marvin wrote:
> > > what about adding these defaults:
> > > 	- CONFIG_SCHED_SMT
> > > 	- CONFIG_HUGETLBFS (needed by ibm cell sdk)
>=20
> I'm using these for years now ;-)
>=20
> > > not sure about:
> > > 	- CONFIG_SPU_FS_64K_LS
>=20
> I also have this option enabled. I think you can forget about it, as it s=
eems=20
> to improve performance only in some corner cases. I'm not an expert, so m=
aybe=20
> asking at cbe-oss-dev would be a better place.=20

Assuming it works on PS3 (the HV lets us use 64k pages I take it?) I
think it should be enabled.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-/FjtJNYTTGXeiJHBV62H
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIIDhBdSjSd0sB4dIRAmq5AJ9ME9pdJYY9bVozXvsnz0xtQlYiSgCgsdY6
J9KNz/r6HAMtNlsKv0t3rHY=
=DisV
-----END PGP SIGNATURE-----

--=-/FjtJNYTTGXeiJHBV62H--
