Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1AFE9DDE2F
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 19:28:49 +1100 (EST)
Date: Mon, 26 Nov 2007 08:28:41 +0000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Add for_each_child_of_node() helper for iterating over
	child nodes
Message-Id: <20071126082841.3e3179b3.sfr@canb.auug.org.au>
In-Reply-To: <e68326d47ae49fee03c635514d5a86a566b13ff9.1196064155.git.michael@ellerman.id.au>
References: <e68326d47ae49fee03c635514d5a86a566b13ff9.1196064155.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__26_Nov_2007_08_28_41_+0000_ut/D_CZaR9AyZtuQ"
Cc: linuxppc-dev@ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__26_Nov_2007_08_28_41_+0000_ut/D_CZaR9AyZtuQ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Nov 2007 19:03:45 +1100 (EST) Michael Ellerman <michael@ellerman=
.id.au> wrote:
>
> Add for_each_child_of_node() to encapsulate the common idiom of
> iterating over the children of a device_node.
>=20
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__26_Nov_2007_08_28_41_+0000_ut/D_CZaR9AyZtuQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHSoPATgG2atn1QN8RAuC/AJ9fo3ql91h4Zlek1ZZ99wwJ8zUMuwCeMDbT
h2hVB1JD4eo3NPwrZVuj+fo=
=9hbH
-----END PGP SIGNATURE-----

--Signature=_Mon__26_Nov_2007_08_28_41_+0000_ut/D_CZaR9AyZtuQ--
