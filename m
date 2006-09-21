Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] kexec: remove memory reserve patching for powerpc
	device tree
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20060921011031.4BFEA67BCE@ozlabs.org>
References: <20060921011031.4BFEA67BCE@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-V6Nct7dCyHqJV2GU0bYv"
Date: Thu, 21 Sep 2006 11:59:04 +1000
Message-Id: <1158803944.7062.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Fastboot mailing list <fastboot@lists.osdl.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-V6Nct7dCyHqJV2GU0bYv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-09-21 at 11:10 +1000, Michael Neuling wrote:
> This code no longer needed with Jimi's auto reserve of device tree blob
> kernel patch now in 2.6.18.   =20
>=20
> This patch will break Linux if you're kexecing to a kernel which doesn't
> have this patch (ie. earlier than 2.6.17).  Required kernel patch is
> this one:  =20
> http://git.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dcommit;h=3D4d1f3f25d9c303d1ce63b42cc94c54ac0ab2e950
>=20

Although it'd be nice to get rid of that code, I'm not sure we want to
go breaking this. This will mean RHEL5 and SLES10 users can't use
upstream kexec-tools :/

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-V6Nct7dCyHqJV2GU0bYv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFEfHodSjSd0sB4dIRAjY/AKCida4nGgRohDOVHr/R8roPNghgvwCeJeUa
FavxG3gEmQPGNhp6KqIYGvw=
=hBZW
-----END PGP SIGNATURE-----

--=-V6Nct7dCyHqJV2GU0bYv--
