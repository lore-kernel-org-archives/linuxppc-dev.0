Return-Path: <B11780@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 35B1FB6F85
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2011 15:26:49 +1100 (EST)
Received: from mail33-ch1 (localhost.localdomain [127.0.0.1])	by
 mail33-ch1-R.bigfish.com (Postfix) with ESMTP id 464E54383A9	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2011 04:26:44 +0000 (UTC)
Received: from CH1EHSMHS016.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.240])	by mail33-ch1.bigfish.com (Postfix) with ESMTP id
 2FC9992804D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2011 04:26:44 +0000 (UTC)
Subject: Re: [PATCH] powerpc/85xx: Fix doorbells
MIME-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1318378002-32531-1-git-send-email-msm@freescale.com>
Date: Tue, 11 Oct 2011 23:26:43 -0500
Message-ID: <C9B7BE2B-1D3E-4B95-BAD0-85F988ED6BA8@freescale.com>
References: <1318378002-32531-1-git-send-email-msm@freescale.com>
To: Matthew McClintock <msm@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 11, 2011, at 7:06 PM, Matthew McClintock wrote:

> Commit 765342526246c97600e5344c0949824d94bb51c3 made some small
> changes to IPI, message_pass in smp_ops was initialized to NULL
> for other platforms but not for 85xx which causes us to always
> use the mpic for IPI's. This patch makes doorbells work again.
> 
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
> arch/powerpc/platforms/85xx/smp.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

applied (updated commit message a bit).

- k
