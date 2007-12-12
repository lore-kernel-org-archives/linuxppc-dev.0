Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 54E5DDDE45
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 20:37:35 +1100 (EST)
Date: Wed, 12 Dec 2007 20:37:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 1/2] Make setjmp/longjmp code generic
Message-Id: <20071212203727.f3719e4a.sfr@canb.auug.org.au>
In-Reply-To: <1197446814.8385.104.camel@pasglop>
References: <20071212054512.882AC62C070@localhost.localdomain>
	<B07AAF57-E87C-40CF-A550-7F868497A2CB@kernel.crashing.org>
	<1197446814.8385.104.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__12_Dec_2007_20_37_27_+1100_RTcwWnioDbr+J_38"
Cc: Neuling <mikey@neuling.org>, THEMANN@de.ibm.com, Michael,
	linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__12_Dec_2007_20_37_27_+1100_RTcwWnioDbr+J_38
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Dec 2007 19:06:54 +1100 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> Time to introduce a merged misc.S ? :-)

We already have one ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__12_Dec_2007_20_37_27_+1100_RTcwWnioDbr+J_38
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHX6vcTgG2atn1QN8RAhWJAJ9Gg0iRydOP0vVVxyJP8db64sQkxACfaH4L
0aENfwP5HFf5WwqoDrF4Nos=
=FsoL
-----END PGP SIGNATURE-----

--Signature=_Wed__12_Dec_2007_20_37_27_+1100_RTcwWnioDbr+J_38--
