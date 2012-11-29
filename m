Return-Path: <R1AAHA@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 593BD2C008F
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2012 08:38:56 +1100 (EST)
Received: from mail37-ch1 (localhost [127.0.0.1])	by mail37-ch1-R.bigfish.com
 (Postfix) with ESMTP id 8E3CC3E022B	for <linuxppc-dev@ozlabs.org>;
 Thu, 29 Nov 2012 21:38:52 +0000 (UTC)
Received: from CH1EHSMHS016.bigfish.com (snatpool3.int.messaging.microsoft.com
 [10.43.68.229])	by mail37-ch1.bigfish.com (Postfix) with ESMTP id
 8C07720047
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2012 21:38:51 +0000 (UTC)
Date: Thu, 29 Nov 2012 15:36:26 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Vakul Garg <vakul@freescale.com>
Subject: Re: [PATCH] dts/t4240: Added SEC-5.0 device tree.
Message-ID: <20121129153626.ca938530268c54777e335334@freescale.com>
In-Reply-To: <1354163290-20431-1-git-send-email-vakul@freescale.com>
References: <1354163290-20431-1-git-send-email-vakul@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 29 Nov 2012 09:58:10 +0530
Vakul Garg <vakul@freescale.com> wrote:

> Signed-off-by: Vakul Garg <vakul@freescale.com>
> ---
> This patch has a dependency on the patch titled:
> "Corrected PAMU device address range to encompass 6 PAMU partitions."
> 
>  arch/powerpc/boot/dts/fsl/qoriq-sec5.0-0.dtsi |  109 +++++++++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi   |    2 +
>  2 files changed, 111 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec5.0-0.dtsi

um, t4240 support isn't upstream yet.

Kim
