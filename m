Return-Path: <R1AAHA@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D7CB92C0087
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2012 10:07:04 +1000 (EST)
Date: Thu, 13 Sep 2012 19:04:39 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Subject: Re: [PATCH] edac/85xx: fix error handle of mpc85xx_mc_err_probe
Message-ID: <20120913190439.64ef56f8566328b23f3843db@freescale.com>
In-Reply-To: <1347533729-5893-1-git-send-email-Shaohui.Xie@freescale.com>
References: <1347533729-5893-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: akpm@linux-foundation.org, avorontsov@mvista.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 13 Sep 2012 18:55:29 +0800
Shaohui Xie <Shaohui.Xie@freescale.com> wrote:

> Error handle in case of DDR ECC off is wrong, sysfs entries have not been
> created, so edac_mc_free which frees a mci instance should not be called.
> Also, free mci's memory in this case.
> 
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---

this fixes a 'WARNING: at lib/kobject.c:593' on a p2020, so:

Tested-by: Kim Phillips <kim.phillips@freescale.com>

Kim
