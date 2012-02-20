Return-Path: <xenidis@gmail.com>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
 [209.85.213.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 73C25B6F9F
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2012 01:12:35 +1100 (EST)
Received: by yhfq11 with SMTP id q11so2507551yhf.15
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2012 06:12:32 -0800 (PST)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
Subject: Re: [PATCH] powerpc/of: add OF_DYNAMIC for chroma
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <5145.1329691681@neuling.org>
Date: Mon, 20 Feb 2012 08:12:27 -0600
Message-Id: <5A594805-C5CE-46E7-A15F-DF86E6FE6C42@pobox.com>
References: <5145.1329691681@neuling.org>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 19, 2012, at 4:48 PM, Michael Neuling wrote:

> linux next-20120217 compiling ppc64e_defconfig fails with:
>=20
> arch/powerpc/platforms/wsp/h8.c: In function 'wsp_h8_getaddr':
> arch/powerpc/platforms/wsp/h8.c:116: error: implicit declaration of =
function 'of_detach_node'
>=20
> The below fixes this by selecting the new OF_DYNAMIC when PPC_CHROMA.
>=20
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Acked-by: Jimi Xenidis <jimix@pobox.com>

>=20
> diff --git a/arch/powerpc/platforms/wsp/Kconfig =
b/arch/powerpc/platforms/wsp/Kconfig
> index 57d22a2..79d2225 100644
> --- a/arch/powerpc/platforms/wsp/Kconfig
> +++ b/arch/powerpc/platforms/wsp/Kconfig
> @@ -25,6 +25,7 @@ config PPC_CHROMA
> 	bool "PowerEN PCIe Chroma Card"
> 	select EPAPR_BOOT
> 	select PPC_WSP
> +	select OF_DYNAMIC
> 	default y
>=20
> endmenu
