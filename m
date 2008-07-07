Return-Path: <sfr@canb.auug.org.au>
Date: Mon, 7 Jul 2008 15:32:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: benh@kernel.crashing.org
Subject: Re: [patch 05/11] powerpc/cell: add spu aware cpufreq governor
Message-Id: <20080707153226.a12f4de2.sfr@canb.auug.org.au>
In-Reply-To: <1215408119.8970.67.camel@pasglop>
References: <20080704190535.316377278@arndb.de>
	<20080704190806.162475834@arndb.de>
	<1215408119.8970.67.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__7_Jul_2008_15_32_26_+1000_uy70wknP.rTAeH_u"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, arnd@arndb.de, Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__7_Jul_2008_15_32_26_+1000_uy70wknP.rTAeH_u
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 07 Jul 2008 15:21:59 +1000 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> On Fri, 2008-07-04 at 21:05 +0200, arnd@arndb.de wrote:
> > plain text document attachment
> > (0005-powerpc-cell-add-spu-aware-cpufreq-governor.patch)

We probably don't need to know that :-)

> > This patch adds a cpufreq governor that takes the number of running spus
> > into account. It's very similar to the ondemand governor, but not as co=
mplex.
> > Instead of hacking spu load into the ondemand governor it might be easi=
er to
> > have cpufreq accepting multiple governors per cpu in future.
> > Don't know if this is the right way, but it would keep the governors si=
mple.
> >=20
> > Signed-off-by: Christian Krafft <krafft@de.ibm.com>
>=20
> Arnd, your S-O-B ?

And a leading From line if it was written by Christian.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__7_Jul_2008_15_32_26_+1000_uy70wknP.rTAeH_u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhxqmoACgkQjjKRsyhoI8xqqgCfYJH7+NtN3/MiLl8+VDrCyldP
IYoAnivDzX1K0mJCW25klguQ4V9ahkQF
=9qxO
-----END PGP SIGNATURE-----

--Signature=_Mon__7_Jul_2008_15_32_26_+1000_uy70wknP.rTAeH_u--
