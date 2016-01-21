Return-Path: <marvin24@gmx.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E3631A006B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 20:51:51 +1100 (AEDT)
From: Marc Dietrich <marvin24@gmx.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Enable VMX copy on PPC970 (G5)
Date: Thu, 21 Jan 2016 10:51:21 +0100
Message-ID: <7901441.McfCmZyUcA@fb07-iapwap2>
In-Reply-To: <1453335927-17419-1-git-send-email-mpe@ellerman.id.au>
References: <1453335927-17419-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1542278.eS5gSRQaYl";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart1542278.eS5gSRQaYl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 21. Januar 2016, 11:25:27 schrieb Michael Ellerman:
> There's no reason I'm aware of that the VMX copy loop shouldn't work on
> PPC970. And in fact it seems to boot and generally be happy.

does the same also hold for Cell? Maybe there are even more optimizations 
which can be copied from PPC970.

Marc 


> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/cputable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/cputable.h
> b/arch/powerpc/include/asm/cputable.h index b118072670fb..f412666fafe2
> 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -411,7 +411,7 @@ enum {
>  	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_201 | \
>  	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CAN_NAP | CPU_FTR_MMCRA | \
>  	    CPU_FTR_CP_USE_DCBTZ | CPU_FTR_STCX_CHECKS_ADDRESS | \
> -	    CPU_FTR_HVMODE | CPU_FTR_DABRX)
> +	    CPU_FTR_HVMODE | CPU_FTR_DABRX | CPU_FTR_VMX_COPY)
>  #define CPU_FTRS_POWER5	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
>  	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
>  	    CPU_FTR_MMCRA | CPU_FTR_SMT | \

--nextPart1542278.eS5gSRQaYl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWoKoZAAoJEKyeR39HFBtoPCcH/0OcS8LIhTDgbzXRsX2i7Mcj
FPHJYWLwclXR30E5c4GLscqZwdY9hAsw89Vz2eL4a9eDyej7mCJBlZvBDN+4dK+N
IELqMUZlIFj3FSdahGvuUJu8ylG/HO6wbLV6/fiQV04h8PWeFPuYUcvQUjpugmmd
5bfRlaSflDHs0gP3u4QtviTzFKsRzw31VQI8rS5HYBlh4UGkCIl/U/1nsF3T4Ick
yW9yaSEGHtvghAyDMye2baKXg2R9kIPyA3zfi6RhoAQLsYp3bTVomVtckX3Aw8MO
V75EkD/9olhBmRp0Eil+v5a9/WllRbeek+7wD+/AHqmvJMrexocZS5KuGY4U/ZM=
=m+ce
-----END PGP SIGNATURE-----

--nextPart1542278.eS5gSRQaYl--
