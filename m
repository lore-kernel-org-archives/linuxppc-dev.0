Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 858402C0089
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Jul 2013 08:59:56 +1000 (EST)
Received: from mail223-ch1 (localhost [127.0.0.1])	by
 mail223-ch1-R.bigfish.com (Postfix) with ESMTP id 4C3434A0070	for
 <linuxppc-dev@ozlabs.org>; Mon, 22 Jul 2013 22:59:53 +0000 (UTC)
Received: from CH1EHSMHS005.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.235])	by mail223-ch1.bigfish.com (Postfix) with ESMTP id
 9D8B5160046	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jul 2013 22:59:51 +0000
 (UTC)
Date: Mon, 22 Jul 2013 17:59:49 -0500
From: Scott Wood <scottwood@freescale.com>
To: Po Liu <po.liu@freescale.com>
Subject: Re: [4/4] powerpc/85xx: Update mpc85xx_defconfig for C293PCIE
Message-ID: <20130722225948.GA26586@home.buserror.net>
References: <1366854857-22791-4-git-send-email-Po.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1366854857-22791-4-git-send-email-Po.Liu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Mingkai Hu <Mingkai.Hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 25, 2013 at 09:54:17AM +0800, Po Liu wrote:
> From: Mingkai Hu <Mingkai.Hu@freescale.com>
> 
> Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
> 
> ---
> Base on git://git.am.freescale.net/gitolite/mirrors/linux-2.6.git
>  arch/powerpc/configs/mpc85xx_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
> index cf815e8..ddc33a2 100644
> --- a/arch/powerpc/configs/mpc85xx_defconfig
> +++ b/arch/powerpc/configs/mpc85xx_defconfig
> @@ -28,6 +28,7 @@ CONFIG_MPC85xx_MDS=y
>  CONFIG_MPC8536_DS=y
>  CONFIG_MPC85xx_DS=y
>  CONFIG_MPC85xx_RDB=y
> +CONFIG_C293_PCIE=y
>  CONFIG_P1010_RDB=y
>  CONFIG_P1022_DS=y
>  CONFIG_P1022_RDK=y

Please just merge this in with the patch that adds CONFIG_C293_PCIE
support, when you respin that patch.

-Scott
