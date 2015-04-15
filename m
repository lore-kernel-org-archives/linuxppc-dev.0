Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD6171A0BA6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 18:32:39 +1000 (AEST)
Date: Wed, 15 Apr 2015 17:14:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 08/31] vfio: powerpc/spapr: Rework groups
 attaching
Message-ID: <20150415071455.GJ25040@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-9-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="QxN5xOWGsmh5a4wb"
In-Reply-To: <1428647473-11738-9-git-send-email-aik@ozlabs.ru>
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


--QxN5xOWGsmh5a4wb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 04:30:50PM +1000, Alexey Kardashevskiy wrote:
> This is to make extended ownership and multiple groups support patches
> simpler for review.
>=20
> This is a mechanical patch.

I think you're pushing the meaning of that term.  Moving whole slabs
of code by copy/paste I'd call mechanical.  Reworking logic in this
way, not so much.  Say "This should cause no behavioural change" if
that's what you mean.

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Though it's not instantly obvious, it does look as though it makes no
behavioural change though, so:

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QxN5xOWGsmh5a4wb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVLg/vAAoJEGw4ysog2bOSwfYQAKmc9GQPnFJ6najFWQPGoZQM
HLl+JN5TdKJPTZww2aO3eQMzSs8rmT1W0n+ckIWs9f7sZT/ZrQdTgZVzf2d6FwUr
ZBF5t/1x6nDewPmX+/KFN+glrse2O0bk+zTLTizgWyF55zfPytHTuvOKU0MGX9Lc
1dpq3KgVrF5ej4IbbKli4dlix6JOAA5Wi3fMHq7UED2h55gn8Xy0IVO5v8wOrdrc
ziqe4nYbh8ayKKvHuAdtBuw/Xif+pRAbwjFAiZBsr64NoL4wPcpxA8JBN50UHnrq
9mqiB9QGtAlEyC8X/7fOJXVnPYthsbDGfMqxx+NLu8ecNVS6XTv4NE6bvAiSvWpu
bdLyHYlJYFtZq9fuyDYO1jiTDJhlRvZz/XUDKOY462AbS2yir8TEqK3wx6kYmirO
anbr59SmJ5yKiOfbNhzhtFkSC9ycnSEZIp+TSfmXpfc7sqkfW8TMoFEJPk8jG6OM
gsD1KVtryFuSq8uLenDeE/ucHThuUCwYi4FNkXVpq7ermNrcd+rDAG6ln0HcW4nV
QA/6NdLTsd39aF2/Bu/qUKQVBBwl2rRv4AgzI3RvfXcZghi95ebEiXve3Z+UaJqb
m2pd91NjwXyuYtTrpd8TSzYs8j/4Vhlc4H21yn6zJqqbzBetih9EGSiUsroMCFz1
IkdcvkFsy3/v+5dSrRsD
=sxZJ
-----END PGP SIGNATURE-----

--QxN5xOWGsmh5a4wb--
