Return-Path: <sfr@canb.auug.org.au>
Date: Mon, 7 Jul 2008 15:30:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: benh@kernel.crashing.org
Subject: Re: [patch 04/11] powerpc/spufs: add atomic busy_spus counter to
	struct cbe_spu_info
Message-Id: <20080707153012.5106e961.sfr@canb.auug.org.au>
In-Reply-To: <1215407941.8970.63.camel@pasglop>
References: <20080704190535.316377278@arndb.de>
	<20080704190806.032005145@arndb.de>
	<1215407941.8970.63.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__7_Jul_2008_15_30_12_+1000_82nXJ7JyNEpUPsyE"
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

--Signature=_Mon__7_Jul_2008_15_30_12_+1000_82nXJ7JyNEpUPsyE
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 07 Jul 2008 15:19:01 +1000 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> On Fri, 2008-07-04 at 21:05 +0200, arnd@arndb.de wrote:
> > plain text document attachment
> > (0004-powerpc-spufs-add-atomic-busy_spus-counter-to-struc.patch)
> > As nr_active counter includes also spus waiting for syscalls to return
> > we need a seperate counter that only counts spus that are currently run=
ning
> > on spu side. This counter shall be used by a cpufreq governor that targ=
ets
> > a frequency dependent from the number of running spus.
> >=20
> > From: Maxim Shchetynin <maxim@de.ibm.com>
> > Signed-off-by: Christian Krafft <krafft@de.ibm.com>
>=20
> This needs your S-O-B, Arnd, and should go via jk.

And the From line should be the first so the Author is correctly
attributed.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__7_Jul_2008_15_30_12_+1000_82nXJ7JyNEpUPsyE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhxqeQACgkQjjKRsyhoI8wB9ACfar6VKxBSm16Dow1Y1PsCq3dt
AcYAn16xWhKJMdMlqdhtBR56dqsp6Hs0
=y3XK
-----END PGP SIGNATURE-----

--Signature=_Mon__7_Jul_2008_15_30_12_+1000_82nXJ7JyNEpUPsyE--
