Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 548F5DDE24
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 17:17:24 +1000 (EST)
Date: Fri, 25 Jul 2008 17:17:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: benh@kernel.crashing.org
Subject: Re: sfx.c driver build failure
Message-Id: <20080725171715.9287c823.sfr@canb.auug.org.au>
In-Reply-To: <1216966559.11188.85.camel@pasglop>
References: <1216966559.11188.85.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__25_Jul_2008_17_17_15_+1000_=dg3HtgGfsAYefMY"
Cc: list <linux-kernel@vger.kernel.org>,
	Michael Brown <mbrown@fensystems.co.uk>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, Linux,
	Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__25_Jul_2008_17_17_15_+1000_=dg3HtgGfsAYefMY
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Jul 2008 16:15:59 +1000 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> The sfx driver (which happens to be part of some of our test configs)
> fails to build in current Linus tree on powerpc with this error:
>=20
> /home/benh/kernels/linux-powerpc/drivers/net/sfc/efx.c: In function =E2=
=80=98efx_probe_interrupts=E2=80=99:
> /home/benh/kernels/linux-powerpc/drivers/net/sfc/efx.c:845: error: lvalue=
 required as unary =E2=80=98&=E2=80=99 operand

Commit 695a6b456307455a10059512208e8ed0d376ecd3 "topology: work around
topology_core_siblings() breakage" in linux-next (from the cpus4096 tree)
comments out the offending lines ...  With the comment "the topology API
is a mess right now".

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__25_Jul_2008_17_17_15_+1000_=dg3HtgGfsAYefMY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiJffsACgkQjjKRsyhoI8zX6ACeP7LvkzHL3ujlfcXok1av2KZu
z58AoKXXaEI0I5Yy4gWJDtRC5e7SHszi
=o3CA
-----END PGP SIGNATURE-----

--Signature=_Fri__25_Jul_2008_17_17_15_+1000_=dg3HtgGfsAYefMY--
