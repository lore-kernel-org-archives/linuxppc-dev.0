Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4DB05DDE39
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 14:43:05 +1100 (EST)
Date: Sun, 23 Dec 2007 14:42:54 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH 17/21] [POWERPC] Base support for 440SPe "Katmai" eval
	board
Message-Id: <20071223144254.72ef476f.sfr@canb.auug.org.au>
In-Reply-To: <20071221194828.3a6e6299@vader.jdub.homelinux.org>
References: <20071221043938.9C15EDDFBF@ozlabs.org>
	<20071222112105.b24c85c5.sfr@canb.auug.org.au>
	<20071221194828.3a6e6299@vader.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__23_Dec_2007_14_42_54_+1100_VjMht/5dHDM_0=7U"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__23_Dec_2007_14_42_54_+1100_VjMht/5dHDM_0=7U
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Dec 2007 19:48:28 -0600 Josh Boyer <jwboyer@gmail.com> wrote:
>
> On Sat, 22 Dec 2007 11:21:05 +1100
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>=20
> > On Fri, 21 Dec 2007 15:39:34 +1100 Benjamin Herrenschmidt <benh@kernel.=
crashing.org> wrote:
> > >
> > > +++ linux-merge/arch/powerpc/platforms/44x/katmai.c	2007-12-21 14:34:=
33.000000000 +1100
> > > +
> > > +static struct of_device_id katmai_of_bus[] =3D {
> >=20
> > __initdata (preferably) or const, please.
>=20
> I'll fix this with a separate commit.  The same comment applies for all
> the 4xx platforms already in the kernel.

Fine by me.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__23_Dec_2007_14_42_54_+1100_VjMht/5dHDM_0=7U
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHbdlITgG2atn1QN8RAoADAJ9yFwBFMM+XTpLnoypPqPYO58YjDQCfaVcR
l9QqOeHkH7yNTbAGzL8xgLM=
=vwI0
-----END PGP SIGNATURE-----

--Signature=_Sun__23_Dec_2007_14_42_54_+1100_VjMht/5dHDM_0=7U--
