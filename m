Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 144DCDDE04
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 16:07:35 +1000 (EST)
Date: Wed, 18 Jul 2007 16:07:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 01/61] Use strcasecmp() rather than strncasecmp() when
	determining device node compatibility.
Message-Id: <20070718160728.73a747c1.sfr@canb.auug.org.au>
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__18_Jul_2007_16_07_28_+1000_YGk/LxaniG3Ps529"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__18_Jul_2007_16_07_28_+1000_YGk/LxaniG3Ps529
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Jul 2007 20:31:37 -0500 Scott Wood <scottwood@freescale.com> wro=
te:
>
> The current code assumes "foo-bar" must always be compatible with a node
> compatible with "foo", which breaks device trees where this is not so.

This should (at least partly) wait for the OF consolidation patches
(coming shortly), please.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__18_Jul_2007_16_07_28_+1000_YGk/LxaniG3Ps529
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGna4kTgG2atn1QN8RAlriAKCbai4o6Xi7DO+hyhaHIYwdyFHWfgCfTqPL
li9XZy5GORUGZVrRksnTqoA=
=zVQt
-----END PGP SIGNATURE-----

--Signature=_Wed__18_Jul_2007_16_07_28_+1000_YGk/LxaniG3Ps529--
