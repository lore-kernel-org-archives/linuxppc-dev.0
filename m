Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 431111A007F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 16:37:04 +1000 (EST)
Date: Wed, 24 Sep 2014 16:36:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/3] powerpc/kdump: crash_dump.c needs to include io.h
Message-ID: <20140924163657.74b23785@canb.auug.org.au>
In-Reply-To: <1411538232-31516-3-git-send-email-mpe@ellerman.id.au>
References: <1411538232-31516-1-git-send-email-mpe@ellerman.id.au>
 <1411538232-31516-3-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7i26GswEpuZzniMbMc.9Rh="; protocol="application/pgp-signature"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/7i26GswEpuZzniMbMc.9Rh=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Wed, 24 Sep 2014 15:57:12 +1000 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> For __ioremap().

So does that mean that you really want this patch before 2/3 so that you
don't introduce an unnecessary bisection breakage in ppc64_defconfig?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/7i26GswEpuZzniMbMc.9Rh=
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUImaOAAoJEMDTa8Ir7ZwVAzUP+wfVA5M6LlkR7wkNcZMKX36d
AkW2+jpEHGK9F5K7vhEgTzDkt3XJtX3sRqUaTFhcPsCvMMdkoq6fFvRsAyKmatVl
nyzcK1Ss/kvlhfxLTohIQAoxFFGJWbVlpWSa3IW1lB/UgThGp3t7he6vObnQ4fvS
3I1oGb9ekgtswzsKUC2rUwvDYdK6nvlCa+V3p448c6yYLKQXU7JXw4OHDJDbY1Jp
1ALnMNF6f+IOKRYwJ+IMnnpErYpqzvyf/iJNwbj9z3HeveqVfg4RI+ckrV2DBlVS
hCXbQukA/cwjCfevcOtNYCulWkSJ9+VGkDAazntrvC5Ugo/E2cB888CEK1Nxm91v
P7XWEuT1BFi/IT0lxjnIo7cu1Uo/mmSBEqlHfQ+s58rwd8+FivAkPrvIkxCCxYfJ
s7uDJYy6Hb+H8GjpsOcsgg7ZicVXyYuR5OwlHsyTX91P+m1xq65WdN+/A9OFhSU5
xoT0oReK5JC/Yi2YBMamqTMsX9ZL1Ij6x4RmB7J0WlwL6QLxN9ZINMyS/Ogd49gU
+kB2R1mKAzaKcVc2fMwLINsDzhgFFPb5+VG6nxgFgdBCSpkuq1r/Mbi5vEnBXwEy
p5gwPNs7l2dwRiLp1sKnb42FFRkGef1iq4JC/jYCrVrCjpl9IrwXOGlVF2K9kZOS
ymG8vspPPc2D6r6ZZKoX
=IxwU
-----END PGP SIGNATURE-----

--Sig_/7i26GswEpuZzniMbMc.9Rh=--
