Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 947C3DDEF8
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 10:31:41 +1000 (EST)
Date: Thu, 10 Apr 2008 10:31:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 83xx/85xx: Reorganize defconfigs
Message-Id: <20080410103131.f0dcf730.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.0804091017440.18753@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0804091017440.18753@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__10_Apr_2008_10_31_31_+1000_4JJC3wIbEcMxyg0Y"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__10_Apr_2008_10_31_31_+1000_4JJC3wIbEcMxyg0Y
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Wed, 9 Apr 2008 10:18:06 -0500 (CDT) Kumar Gala <galak@kernel.crashing.o=
rg> wrote:
>
> Board specific defconfigs are useful, however with the ability to do
> multi-board defconfigs they aren't needed in the top level configs direct=
ory
>=20
> Move the 83xx/85xx board specific defconfigs to individual directories un=
der
> arch/powerpc/configs.

So do we have multi-board defconfigs for 83xx and/or 85xx?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__10_Apr_2008_10_31_31_+1000_4JJC3wIbEcMxyg0Y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH/V/pTgG2atn1QN8RAgv3AKCGiL6KptDQFefAawIhDOqAVlQvvQCfcKut
fvkEU2jEGGiZq7DgDih6u3w=
=q+M9
-----END PGP SIGNATURE-----

--Signature=_Thu__10_Apr_2008_10_31_31_+1000_4JJC3wIbEcMxyg0Y--
