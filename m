Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 20C40DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 11:40:20 +1100 (EST)
Date: Wed, 11 Feb 2009 11:40:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v4] powerpc: Unify opcode definitions and support
Message-Id: <20090211114011.04f838d6.sfr@canb.auug.org.au>
In-Reply-To: <1234312110-22227-1-git-send-email-galak@kernel.crashing.org>
References: <1234312110-22227-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__11_Feb_2009_11_40_11_+1100_rWh5DauJSd.iKnGO"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__11_Feb_2009_11_40_11_+1100_rWh5DauJSd.iKnGO
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Tue, 10 Feb 2009 18:28:30 -0600 Kumar Gala <galak@kernel.crashing.org> w=
rote:
>
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -0,0 +1,68 @@
> +/*
> + * Copyright (C) 2009 Freescale Semicondutor, Inc. All rights reserved.

If you are going to use "All rights reserved", you should also allow us
to use it under the GPL explicitly ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__11_Feb_2009_11_40_11_+1100_rWh5DauJSd.iKnGO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmSHmsACgkQjjKRsyhoI8zxHACgps5HLqyHKYRRP8KyD6LN6Fk7
BfIAn026WKSw8RkhAM7W0pijnwcYZ/U0
=ViXT
-----END PGP SIGNATURE-----

--Signature=_Wed__11_Feb_2009_11_40_11_+1100_rWh5DauJSd.iKnGO--
