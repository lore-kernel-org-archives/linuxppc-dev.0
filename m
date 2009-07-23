Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5354AB7D16
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 16:22:58 +1000 (EST)
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 44079DDD1B
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2009 16:22:58 +1000 (EST)
Date: Thu, 23 Jul 2009 16:22:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 9/20] powerpc/mm: Call mmu_context_init() from ppc64
Message-Id: <20090723162254.6ba0cb51.sfr@canb.auug.org.au>
In-Reply-To: <20090723055955.757B4DDD1B@ozlabs.org>
References: <20090723055955.757B4DDD1B@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__23_Jul_2009_16_22_54_+1000_452cZw/zOvFkoNv3"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__23_Jul_2009_16_22_54_+1000_452cZw/zOvFkoNv3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Thu, 23 Jul 2009 15:59:44 +1000 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> Index: linux-work/arch/powerpc/mm/mmu_context_hash64.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-work.orig/arch/powerpc/mm/mmu_context_hash64.c	2009-07-22 16:24=
:43.000000000 +1000
> +++ linux-work/arch/powerpc/mm/mmu_context_hash64.c	2009-07-22 16:24:56.0=
00000000 +1000
> @@ -76,3 +76,4 @@ void destroy_context(struct mm_struct *m
> =20
>  	mm->context.id =3D NO_CONTEXT;
>  }
> +

Really? :-(
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__23_Jul_2009_16_22_54_+1000_452cZw/zOvFkoNv3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpoAb4ACgkQjjKRsyhoI8wTUQCgifZWw/FAcVWh21MEL7YDuWBs
4dsAniZR+rPUu9R7UjScxUTA5wqGXNh/
=Gjwc
-----END PGP SIGNATURE-----

--Signature=_Thu__23_Jul_2009_16_22_54_+1000_452cZw/zOvFkoNv3--
