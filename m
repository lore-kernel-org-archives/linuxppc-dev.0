Return-Path: <michael@ellerman.id.au>
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id B0CCDDDEC0
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 11:46:13 +1000 (EST)
Subject: Re: [PATCH] Use of_get_parent() in pci_dma_dev_setup_pSeriesLP()
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <b1a6d99a117d0a0027e3f7dcef4a48f8df68893d.1193199823.git.michael@ellerman.id.au>
References: <b1a6d99a117d0a0027e3f7dcef4a48f8df68893d.1193199823.git.michael@ellerman.id.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Dbi/CmzUABJ94mEv4J/3"
Date: Thu, 25 Oct 2007 11:46:13 +1000
Message-Id: <1193276773.8053.0.camel@concordia>
Mime-Version: 1.0
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Dbi/CmzUABJ94mEv4J/3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-10-24 at 14:24 +1000, Michael Ellerman wrote:
> The loop to check parent nodes for a dma-window property in
> pci_dma_dev_setup_pSeriesLP() does not use the of_* accessors and
> does not properly manage refcounts, fix it to do so.
>=20
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  arch/powerpc/platforms/pseries/iommu.c |   17 ++++++++++++-----
>  1 files changed, 12 insertions(+), 5 deletions(-)

I'm starting to make a habit of this .. but nack.

Stephen points out that there are several other places in this file that
need fixing up, so I'll do them all as one series.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Dbi/CmzUABJ94mEv4J/3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHH/VldSjSd0sB4dIRAglAAJ9IKtDdIboFdKK1RJBlUvs7hwNzyQCdFVy6
h+xNTjuzVMisnG3HigEPB+o=
=rlU0
-----END PGP SIGNATURE-----

--=-Dbi/CmzUABJ94mEv4J/3--
