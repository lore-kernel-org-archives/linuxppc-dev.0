Return-Path: <claudiu.manoil@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 56BB42C00B1
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Nov 2013 21:41:32 +1100 (EST)
Received: from mail224-tx2 (localhost [127.0.0.1])	by
 mail224-tx2-R.bigfish.com (Postfix) with ESMTP id 256CAB80478	for
 <linuxppc-dev@ozlabs.org>; Mon, 11 Nov 2013 10:41:29 +0000 (UTC)
Received: from TX2EHSMHS008.bigfish.com (unknown [10.9.14.236])	by
 mail224-tx2.bigfish.com (Postfix) with ESMTP id 09D62540040	for
 <linuxppc-dev@ozlabs.org>; Mon, 11 Nov 2013 10:41:27 +0000 (UTC)
Message-ID: <5280B44E.50205@freescale.com>
Date: Mon, 11 Nov 2013 12:41:18 +0200
From: Claudiu Manoil <claudiu.manoil@freescale.com>
MIME-Version: 1.0
To: Lijun Pan <Lijun.Pan@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc/85xx: Merge 85xx/p1023_defconfig into
 mpc85xx_smp_defconfig and mpc85xx_defconfig
References: <1383952632-5770-1-git-send-email-Lijun.Pan@freescale.com>
In-Reply-To: <1383952632-5770-1-git-send-email-Lijun.Pan@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/9/2013 1:17 AM, Lijun Pan wrote:
> diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
> index d2e0fab..72fff6e 100644
> --- a/arch/powerpc/configs/mpc85xx_defconfig
> +++ b/arch/powerpc/configs/mpc85xx_defconfig
> @@ -1,4 +1,5 @@
>   CONFIG_PPC_85xx=y
> +CONFIG_SMP=y

mpc85xx_defconfig is targeting single CPU systems, like P1010,
so why enable SMP here since there is a separate mpc85xx_smp_defconfig?

regards,
Claudiu
