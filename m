Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 16DF5DDE45
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jun 2007 10:25:43 +1000 (EST)
Date: Mon, 11 Jun 2007 10:25:33 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Kujau <lists@nerdbynature.de>
Subject: Re: zImage.miboot and vmlinux.lds
Message-Id: <20070611102533.20257a25.sfr@canb.auug.org.au>
In-Reply-To: <alpine.DEB.0.99.0706092327300.8312@foobar-g4>
References: <Pine.LNX.4.64.0705282025250.6275@sheep.housecafe.de>
	<alpine.DEB.0.99.0706092110060.8312@foobar-g4>
	<981f558c34d946fcb2683a9731f8d5ad@kernel.crashing.org>
	<alpine.DEB.0.99.0706092327300.8312@foobar-g4>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__11_Jun_2007_10_25_33_+1000_QLA=HziNcl/rml14"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__11_Jun_2007_10_25_33_+1000_QLA=HziNcl/rml14
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 9 Jun 2007 23:39:20 +0200 (CEST) Christian Kujau <lists@nerdbynatur=
e.de> wrote:
>
> On Sat, 9 Jun 2007, Segher Boessenkool wrote:
> > vmlinux.lds should be cleaned from the main (non-arch)
> > Makefile; I could swear I've sent a patch for that some
> > time ago.
>=20
> Well, Stephen Rothwell did (too?) and you replied to his post:
> http://article.gmane.org/gmane.linux.ports.ppc.devel/5881

That patch actually removed vmlinux.lds for the repository as it had
become a generated file i.e. the patch did not add rules to the Makefile
to remove the file for mrproper.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__11_Jun_2007_10_25_33_+1000_QLA=HziNcl/rml14
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGbJaCFdBgD/zoJvwRAiKpAJ9mrEZU/jwF7OZ2UfZZvRoP64c99gCdFauv
Mz1isd2j76dK/31YWjz0dHs=
=9Dwu
-----END PGP SIGNATURE-----

--Signature=_Mon__11_Jun_2007_10_25_33_+1000_QLA=HziNcl/rml14--
