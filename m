Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 32B47B7CB9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 16:50:35 +1000 (EST)
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 24834DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2009 16:50:35 +1000 (EST)
Date: Thu, 23 Jul 2009 16:50:32 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 13/20] powerpc: Add SPR definitions for new 64-bit BookE
Message-Id: <20090723165032.f7878bce.sfr@canb.auug.org.au>
In-Reply-To: <20090723055959.0D67DDDD1B@ozlabs.org>
References: <20090723055959.0D67DDDD1B@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__23_Jul_2009_16_50_32_+1000_qhJc5cnjqNwEcu8+"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__23_Jul_2009_16_50_32_+1000_qhJc5cnjqNwEcu8+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Thu, 23 Jul 2009 15:59:47 +1000 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> @@ -480,3 +508,4 @@
>  #endif /* 403GCX */
>  #endif /* __ASM_POWERPC_REG_BOOKE_H__ */
>  #endif /* __KERNEL__ */
> +

I know I am being trivial here ... :-)
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__23_Jul_2009_16_50_32_+1000_qhJc5cnjqNwEcu8+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpoCDgACgkQjjKRsyhoI8xoTACeKm8M6GZFxD/VFd/z++ZI/b36
ztQAoKNxg5JiYz7jplX7hlJ2CExZCVub
=1wrs
-----END PGP SIGNATURE-----

--Signature=_Thu__23_Jul_2009_16_50_32_+1000_qhJc5cnjqNwEcu8+--
