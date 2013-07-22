Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 83BF12C008E
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Jul 2013 08:04:51 +1000 (EST)
Received: from mail38-va3 (localhost [127.0.0.1])	by mail38-va3-R.bigfish.com
 (Postfix) with ESMTP id 081CE14025F	for <linuxppc-dev@ozlabs.org>;
 Mon, 22 Jul 2013 22:04:48 +0000 (UTC)
Received: from VA3EHSMHS038.bigfish.com (unknown [10.7.14.250])	by
 mail38-va3.bigfish.com (Postfix) with ESMTP id 0E544260049	for
 <linuxppc-dev@ozlabs.org>; Mon, 22 Jul 2013 22:04:46 +0000 (UTC)
Date: Mon, 22 Jul 2013 17:04:42 -0500
From: Scott Wood <scottwood@freescale.com>
To: Zhenhua Luo <zhenhua.luo@freescale.com>
Subject: Re: Enable CONFIG_DEVTMPFS_MOUNT to ensure /dev can be mounted
 correctly
Message-ID: <20130722220442.GA25557@home.buserror.net>
References: <1365688591-5323-1-git-send-email-zhenhua.luo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1365688591-5323-1-git-send-email-zhenhua.luo@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 11, 2013 at 09:56:30PM +0800, Zhenhua Luo wrote:
> When using recent udev, the /dev node mount requires CONFIG_DEVTMPFS_MOUNT
> is enabled in Kernel. The patch enables the option in defconfig of Freescale
> QorIQ targets.
> 
> Changed defconfig list:
>    arch/powerpc/configs/85xx/p1023rds_defconfig
>    arch/powerpc/configs/corenet32_smp_defconfig
>    arch/powerpc/configs/corenet64_smp_defconfig
>    arch/powerpc/configs/mpc85xx_smp_defconfig

What about mpc83xx and mpc85xx (non-smp)?

It'd be nice if non-hardware-specific things that are required for a
typical Linux system were "default y".  Even nicer if we could have
config fragments for various usage profiles that are separate from
hardware config.

-Scott
