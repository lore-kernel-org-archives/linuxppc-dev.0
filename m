Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 976EB2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 22:02:42 +1100 (EST)
Date: Tue, 4 Dec 2012 22:02:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 2/4] powerpc: enable ARCH_USE_BUILTIN_BSWAP
Message-Id: <20121204220232.35c7ece1f96e20cd884106b6@canb.auug.org.au>
In-Reply-To: <1354616130-21587-3-git-send-email-dwmw2@infradead.org>
References: <1354616130-21587-1-git-send-email-dwmw2@infradead.org>
 <1354616130-21587-3-git-send-email-dwmw2@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__4_Dec_2012_22_02_32_+1100_7M+YI0MirPs/RTAJ"
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__4_Dec_2012_22_02_32_+1100_7M+YI0MirPs/RTAJ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue,  4 Dec 2012 10:15:28 +0000 David Woodhouse <dwmw2@infradead.org> wr=
ote:
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index a902a5c..b4ea516 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -78,6 +78,9 @@ config ARCH_HAS_ILOG2_U64
>  	bool
>  	default y if 64BIT
> =20
> +config ARCH_USE_BUILTIN_BSWAP
> +       def_bool y
> +

This should be defined as bool in arch/Kconfig (probably in the previous
patch) and then selected from appropriate architectures.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__4_Dec_2012_22_02_32_+1100_7M+YI0MirPs/RTAJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQvdhIAAoJEECxmPOUX5FE5XQP/1Htprg35GkDr2wMNiY5sH6D
5d+BlOeEvlEkWXew4ytPkyPWRuL5OSf01/dOPgVtrC1xhIZtH8dqHB+GlXGCUT+X
WAr3zYABvHW/vFkjR5E26FFpN2VzwUlzZVl1RMbLajlFkm4dv8ORcW+nbfEQpONM
S4FQ7t1bmG/8VVkGMX43o50uGgrNP0QfdGOnIEmCoI34F10viVNWlfyLtwXoFFWR
/HP3riiLN9WNjtuTCbA+2W9v8doy7ZPtObrDR3/gAVrcJeo7zRcw7wwSLspCVK6U
ZROQNfbNri8T5ZUp4hIH3/1Kvvs3CsCcBDR9/se+ythSOD9laV+HQyyCS+0zUHky
sg6PrH8/+dpHwBYW7zHAJFTjNk7plbxluTw7VynQyvUc+42wg9pGglMkfChhKK1K
A6YXmkgmWG9DKpuG2lplBziS96CKjQIVRsa1GOkofS9lvj/o4deh+oHYV2weiNG6
OHe2NGQTpxnI6d07p9bZHyvcZmmmUTvddh1r1cdgzrmZiVWob42eIPZRC0252DSi
B5AAncjilaw8Sb1TWKWl7LrE69thazqKIRDcyHDrgqm5RaSwtfojC80TJNa/ZoTq
kmmj8W5M6zXA2c/SxxOxlDWyb+1ufMJhXDCYSr12aSLWy9FXYp+MxhCVUYr/vzle
sPICbn+NO9O5rCwm+MoZ
=k775
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Dec_2012_22_02_32_+1100_7M+YI0MirPs/RTAJ--
