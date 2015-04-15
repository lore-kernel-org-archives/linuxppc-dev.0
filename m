Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B7411A0B87
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 16:10:09 +1000 (AEST)
Date: Wed, 15 Apr 2015 14:09:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 05/31] vfio: powerpc/spapr: Move locked_vm
 accounting to helpers
Message-ID: <20150415040915.GF25040@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-6-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="JcvBIhDvR6w3jUPA"
In-Reply-To: <1428647473-11738-6-git-send-email-aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--JcvBIhDvR6w3jUPA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 04:30:47PM +1000, Alexey Kardashevskiy wrote:
> There moves locked pages accounting to helpers.
> Later they will be reused for Dynamic DMA windows (DDW).
>=20
> This reworks debug messages to show the current value and the limit.
>=20
> This stores the locked pages number in the container so when unlocking
> the iommu table pointer won't be needed. This does not have an effect
> now but it will with the multiple tables per container as then we will
> allow attaching/detaching groups on fly and we may end up having
> a container with no group attached but with the counter incremented.
>=20
> While we are here, update the comment explaining why RLIMIT_MEMLOCK
> might be required to be bigger than the guest RAM. This also prints
> pid of the current process in pr_warn/pr_debug.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JcvBIhDvR6w3jUPA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVLeRrAAoJEGw4ysog2bOSWOEQALYjA9ivZxL7aAXjmVLnphtT
jSX8ecLUTdyOtCAJ8QRAMN+r+e3BCItlVRx0xuRr4it0QvrZgDxHgsB6fq7Zg1ha
EMORgnN22UfC0pF+sTTdob1WvGiRHgHohwiSLiRvyApz0pv2BIGUuUbDmCQTWIYc
Q+Z5rwcU6nCb15SXrUwzUFrulMfyYgwacMv9oAcO07yaClvSSXiIkzyAmzhHiLc5
uYuVezeI2+WynlpTFHoK4CqVV7jRZyTgFUtIyQFxI2pE3QmtkZ0OFnW0l9dOxcGW
H+3C+jiHj03/P7kMYyjxZOMGnLtkaXwjcaeRnB2F+qx+AA4rjGLFFDhixA+rK2tp
KzWsWcxg9y6lTcOG9fVq4LkXgYaELtfKnNbdBqeDEETHp9Gq/T1tbRGL4TgO/t8b
/hmsnyeXI1TYi3Qax4qQ1YcFn5X7/n1j9No+MZOuSGCNCqlSCSy+qnHd70AluWW5
9B2LNRdFyQUS12FD8kCd2/DAkUqqSkhC+BP6PgDR8EYdZ/OkoHn/76nIA6RM5NHj
acSfdKfbVJgeqUxPNYOTjsUHHaFSIQVhorOgo9glFrlSqBGv83uJRexMCe5OWURa
raLBQtzotT2BYPlWEzVHpZgefKiIf4uiSiuSlNvTKTVB6t8e/6gZumumlFIim+n4
jMTMGgpbwNrkfeYOWYRH
=mLY6
-----END PGP SIGNATURE-----

--JcvBIhDvR6w3jUPA--
