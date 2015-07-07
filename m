Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 553D41A0E4E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 07:51:40 +1000 (AEST)
Message-ID: <1436305887.2658.49.camel@freescale.com>
Subject: Re: [RESEND] powerpc/diu: adjust DIU initialization entry
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
CC: <yorksun@freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <jason.jin@freescale.com>
Date: Tue, 7 Jul 2015 16:51:27 -0500
In-Reply-To: <1436255497-41207-1-git-send-email-dongsheng.wang@freescale.com>
References: <1436255497-41207-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-07-07 at 15:51 +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Move fsl_diu_init into diu probe function, because it should be
> initialized when system get diu device tree node, not always do
> initialization.
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> Changes:
> Rebase original patch for upstream because fsl-diu-fb.c has moved to fbdev 
> dir.
> 
> This patch is a long time ago, there is no feedback, and the Patchwork state
> has been modified for the changes requested, I don't know why. So I resend
> this patch to upstream.

Please send this to the proper list and maintainer, and with a subject prefix 
that indicates it's an fbdev patch.

-Scott
