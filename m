Return-Path: <dgibson@ozlabs.org>
Date: Wed, 31 Jan 2007 15:57:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH 2/3] [POWERPC] Fix kernel build errors for mpc8272ads and
	mpc8560ads
Message-ID: <20070131045759.GB25231@localhost.localdomain>
References: <20070130230711.21111.52924.stgit@localhost.localdomain>
	<20070130230859.21111.39370.stgit@localhost.localdomain>
	<F739E1EE-3BA6-428D-8C96-AB09E1B9773B@kernel.crashing.org>
	<20070131073947.67520c16@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
In-Reply-To: <20070131073947.67520c16@localhost.localdomain>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2007 at 07:39:47AM +0300, Vitaly Bordug wrote:
> On Tue, 30 Jan 2007 17:41:14 -0600
> Kumar Gala wrote:
>=20
> >=20
> > On Jan 30, 2007, at 5:09 PM, Vitaly Bordug wrote:
> >=20
> > >
> > > Recent update of asm-powerpc/io.h caused cpm-related stuff to
> > > break in the
> > > current kernel. Current patch fixes it, as well as other =20
> > > inconsistencies
> > > expressed, that do not permit targets from working properly:
> > >
> > > - Updated dts with a chosen node with interrupt controller,
> >=20
> > Why do we need this?  I'm not aware of any other boards having to
> > set this?
>=20
> Correct. In fact I dropped that change, after "dtc -f" discussion
> but forgot to clear this line from desc. Will resend in a few
> minutes, thanks for pointing it out.

Oh.. if this is no longer needed we should just remove the check from
dtc.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFFwCHXaILKxv3ab8YRAi8zAJ9ZuaTVanJCADMobjmJJz4/nT99ywCfRaic
QyzwGouIFNJzsd+Mk1msLbk=
=BwSv
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
