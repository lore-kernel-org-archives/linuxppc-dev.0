Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Remove stale iseries global
From: Michael Ellerman <michael@ellerman.id.au>
To: will_schmidt@vnet.ibm.com
In-Reply-To: <1145381474.20493.5.camel@localhost.localdomain>
References: <20060418162553.GC26746@pb15.lixom.net>
	<1145381474.20493.5.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ZRPVS7bCKw8RmxEyVNdK"
Date: Tue, 18 Apr 2006 19:54:22 +0200
Message-Id: <1145382862.20176.5.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ZRPVS7bCKw8RmxEyVNdK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-04-18 at 12:31 -0500, Will Schmidt wrote:
> On Tue, 2006-04-18 at 11:25 -0500, Olof Johansson wrote:
> > Hi,
> >=20
> > Not even the iSeries maintainer seems to have access to this legendary
> > piranha simulator. It adds a bit of ugliness in the common time init
> > code, and if it's no longer used we might as well be done with it and
> > remove the bloat.
>=20
> Yes, the piranha tools are no longer used with linux.   I see no reason
> why this needs to stay. =20

So can we get rid of this from head_64.S as well? Or is that a different
debugger?

        /*
         * At offset 0x28 and 0x30 are offsets to the mschunks_map
         * array (used by the iSeries LPAR debugger to do translation
         * between physical addresses and absolute addresses) and
         * to the pidhash table (also used by the debugger)
         */
        .llong mschunks_map-KERNELBASE
        .llong 0        /* pidhash-KERNELBASE SFRXXX */

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ZRPVS7bCKw8RmxEyVNdK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBERSfOdSjSd0sB4dIRAvfiAJ4mtqoCMF1Cgx5oO9isdqplvXjA3gCeNsiM
Nx13+NtTVjdfZJrCWgW6kMc=
=5ylZ
-----END PGP SIGNATURE-----

--=-ZRPVS7bCKw8RmxEyVNdK--
