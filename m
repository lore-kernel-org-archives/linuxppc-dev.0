Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe002.messaging.microsoft.com
 [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A156BB71AB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2012 03:39:53 +1100 (EST)
Received: from mail36-db3 (localhost [127.0.0.1])	by mail36-db3-R.bigfish.com
 (Postfix) with ESMTP id CC0EEC0572	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2012 16:39:47 +0000 (UTC)
Received: from DB3EHSMHS007.bigfish.com (unknown [10.3.81.253])	by
 mail36-db3.bigfish.com (Postfix) with ESMTP id 450122C004C	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2012 16:39:46 +0000 (UTC)
Message-ID: <4F32A54F.5090305@freescale.com>
Date: Wed, 8 Feb 2012 10:39:43 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao <B38951@freescale.com>
Subject: Re: [linuxppc-release] [PATCH 2/2] powerpc/85xx: update SEC node
 in dts for MPC8572DS
References: <1328693276-12057-1-git-send-email-B38951@freescale.com>
 <1328693276-12057-2-git-send-email-B38951@freescale.com>
In-Reply-To: <1328693276-12057-2-git-send-email-B38951@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jia Hongtao wrote:
> Add sec3.1 support
> 
> Signed-off-by: Jin Qing <b24347@freescale.com>
> Signed-off-by: Zhao Chenhui <b35336@freescale.com>
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi
> index d44e25a..cdda34f 100644
> --- a/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi
> @@ -184,7 +184,7 @@
>  /include/ "pq3-etsec1-1.dtsi"
>  /include/ "pq3-etsec1-2.dtsi"
>  /include/ "pq3-etsec1-3.dtsi"
> -/include/ "pq3-sec3.0-0.dtsi"
> +/include/ "pq3-sec3.1-0.dtsi"

This is not "adding SEC 3.1 support".  This patch is saying that the 8572
DTS was using the *wrong* SEC version.  If that's true, you need to
explain why it was wrong.

-- 
Timur Tabi
Linux kernel developer at Freescale
