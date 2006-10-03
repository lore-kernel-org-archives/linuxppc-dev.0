Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A0D4E67C00
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 05:05:52 +1000 (EST)
Date: Tue, 3 Oct 2006 23:05:43 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull upstream branch of linux-2.6-PQ.git...
Message-ID: <20061003230543.6cc82325@localhost.localdomain>
In-Reply-To: <E0C344B6-3149-46E4-8573-6EA220F4D7FE@kernel.crashing.org>
References: <20061003223054.06e25136@localhost.localdomain>
	<E0C344B6-3149-46E4-8573-6EA220F4D7FE@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_rjgKsA7ToPfkEpptF27uAvx;
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_rjgKsA7ToPfkEpptF27uAvx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Oct 2006 13:43:35 -0500
Kumar Gala wrote:

>=20
> On Oct 3, 2006, at 1:30 PM, Vitaly Bordug wrote:
>=20
> > Paul,
> >
> > Please do a pull from
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/vitb/linux-2.6-=20
> > PQ.git, upstream branch.
> >
> > Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> >
> >
> > To receive the updated 8272 addition to the  arch/powerpc.
> > All the comments have been addressed, and it has a minor bugfix =20
> > addressed too in order to make both pq2 and pq3
> > co-exist happily in fsl_soc.c. CPM PIC now has "compatible" =20
> > property that could be "CPM2" or "CPM1" for PQ/8xx.
> >
> > I think it should go to rc1, because relevant stuff in ppc/ is
> > more or less broken now, with new irq engine.
> >
> > --
> >
> >  arch/powerpc/Kconfig                      |    1
> >  arch/powerpc/boot/dts/mpc8272ads.dts      |  223 ++++++++++
> >  arch/powerpc/platforms/82xx/Kconfig       |   21
> >  arch/powerpc/platforms/82xx/Makefile      |    5
> >  arch/powerpc/platforms/82xx/m82xx_pci.h   |   19
> >  arch/powerpc/platforms/82xx/mpc82xx.c     |  111 +++++
> >  arch/powerpc/platforms/82xx/mpc82xx_ads.c |  661
> > ++++++++++++++++++ ++++++++++++
> >  arch/powerpc/platforms/82xx/pq2ads.h      |   67 +++
> >  arch/powerpc/sysdev/cpm2_pic.c            |    2
> >  arch/powerpc/sysdev/cpm2_pic.h            |    2
> >  arch/powerpc/sysdev/fsl_soc.c             |   62 ++
> >  11 files changed, 1165 insertions(+), 9 deletions(-)
>=20
> Are there updates to the flat dev spec for the CPM nodes?  That is
> my only hold up on ack'ing all this good PQ2/PQ3 CPM work.
>=20

It is coming along with QE docs, on top of it, since we decided to make CPM=
 a "sibliing".
I'll follow-up with the stuff in the separate domain if we've no chance to =
get QE thing in this time.
Though, tha't not what will be good, because we should keep clear, how simi=
lar are CPM and QE.

Again, most of the node things are self-explanatory and assuming ppc/ entit=
y of 8272 does not=20
function properly anymore, I really want this in rc1. There are many boards=
 like it, so this will encourage people=20
to move to the powerpc which with a reference much more simple than fix ppc=
/ irq stuff.

So, as a recap physically spec is ready, just depending on QE spec that is =
floating around still :)
And, having 85xx cpm2 stuff in the Linus' mainline atm, there's no much rea=
son holding this, is there ;) ?
=20
--
Thanks,=20
-Vitaly

--Sig_rjgKsA7ToPfkEpptF27uAvx
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFIrSHuOg9JvQhSEsRAs/gAKCMjA8cENRq5j6XDkJPetEY2ZjCWwCfcMc2
5FMF2z9KSSTjQFELkD3fHQc=
=kNNA
-----END PGP SIGNATURE-----

--Sig_rjgKsA7ToPfkEpptF27uAvx--
