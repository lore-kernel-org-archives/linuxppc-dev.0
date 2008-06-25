Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 69CC5DDF05
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 17:12:26 +1000 (EST)
Date: Wed, 25 Jun 2008 17:12:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: michael@ellerman.id.au
Subject: Re: Do we still need devtree_lock?
Message-Id: <20080625171215.0a10729d.sfr@canb.auug.org.au>
In-Reply-To: <1214349928.7273.1.camel@localhost>
References: <48617FA4.7070603@freescale.com>
	<1214349928.7273.1.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__25_Jun_2008_17_12_15_+1000_wLbqeDgFa=QNC5l9"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__25_Jun_2008_17_12_15_+1000_wLbqeDgFa=QNC5l9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Jun 2008 09:25:28 +1000 Michael Ellerman <michael@ellerman.id.au=
> wrote:
>
> > extern rwlock_t devtree_lock;	/* temporary while merging */
> >=20
> > Since arch/ppc is going away, does this meant that the lock can go away=
 do?
>=20
> You wish :)  That /would/ make life easier.
>=20
> I think the comment just refers to the extern declaration being in
> the .c file, rather than a header - ie. now that the merge is done we
> should clean it up and put it in a header.

The merge referred to is the merge between the Sparc and Powerpc device
tree accessing functions.  This is not complete and I need to get back to
it.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__25_Jun_2008_17_12_15_+1000_wLbqeDgFa=QNC5l9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhh788ACgkQTgG2atn1QN+K/QCeNzVX1CEqmxvwV1j0DLuY3kmt
hrYAmwdSfyme8Mj1dSl5zmO9KfgynmAM
=U0m9
-----END PGP SIGNATURE-----

--Signature=_Wed__25_Jun_2008_17_12_15_+1000_wLbqeDgFa=QNC5l9--
