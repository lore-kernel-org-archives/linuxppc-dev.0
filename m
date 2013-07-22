Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7BFBF2C01C5
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Jul 2013 09:00:33 +1000 (EST)
Received: from mail195-co9 (localhost [127.0.0.1])	by
 mail195-co9-R.bigfish.com (Postfix) with ESMTP id 121BDB0012F	for
 <linuxppc-dev@ozlabs.org>; Mon, 22 Jul 2013 23:00:31 +0000 (UTC)
Received: from CO9EHSMHS009.bigfish.com (unknown [10.236.132.250])	by
 mail195-co9.bigfish.com (Postfix) with ESMTP id 66679D00047	for
 <linuxppc-dev@ozlabs.org>; Mon, 22 Jul 2013 23:00:29 +0000 (UTC)
Date: Mon, 22 Jul 2013 18:00:27 -0500
From: Scott Wood <scottwood@freescale.com>
To: Po Liu <po.liu@freescale.com>
Subject: Re: [4/4] powerpc/85xx: Update mpc85xx_defconfig for C293PCIE
Message-ID: <20130722230026.GA26621@home.buserror.net>
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

Also, why only mpc85xx_defconfig and mpc85xx_smp_defconfig?  Just because
this board isn't SMP doesn't mean it can't be supported by an SMP kernel.

-Scott
