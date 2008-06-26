Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 12/14] powerpc: Add logic to patch alternative feature
	sections
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <048926C3-B5B8-4E99-BCDD-B545CF8112B6@kernel.crashing.org>
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
	<4405563e1705f79e64477ec96f39abb4d57397dc.1214271072.git.michael@ellerman.id.au>
	<048926C3-B5B8-4E99-BCDD-B545CF8112B6@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-eS8lN3np+46ejxHXUje2"
Date: Thu, 26 Jun 2008 13:45:35 +1000
Message-Id: <1214451935.32022.6.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-eS8lN3np+46ejxHXUje2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-06-24 at 08:47 -0500, Kumar Gala wrote:
> On Jun 23, 2008, at 8:33 PM, Michael Ellerman wrote:
>=20
> > This patch adds the logic to patch alternative sections. This is =20
> > fairly
> > straight forward, except for branches. Relative branches that jump =20
> > from
> > inside the else section to outside of it, need to be translated as =20
> > they're
> > moved, otherwise they will jump to the wrong location.
>=20
> this should really be part of the 'Introduce infrastructure for =20
> feature sections with alternatives' patch.  The two are really coupled =20
> (one doesn't make sense w/o the other).

I guess, although I did implement it this way, in two stages - it just
means the ALT_ macros are non-functional for one commit. I can respin if
you really want.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-eS8lN3np+46ejxHXUje2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIYxDfdSjSd0sB4dIRAnQEAJ4vsW/RThfGE8TSHaaj510kzSGA3QCfVuKL
baozCPZVcy75qeLCL8qc+9A=
=+hrx
-----END PGP SIGNATURE-----

--=-eS8lN3np+46ejxHXUje2--
