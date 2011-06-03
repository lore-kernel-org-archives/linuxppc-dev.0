Return-Path: <B11780@freescale.com>
Received: from CH1EHSOBE017.bigfish.com (ch1ehsobe003.messaging.microsoft.com
	[216.32.181.183]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 52F9DB6FA9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jun 2011 17:57:34 +1000 (EST)
Received: from mail142-ch1 (localhost.localdomain [127.0.0.1])	by
	mail142-ch1-R.bigfish.com (Postfix) with ESMTP id 6246815F832E	for
	<linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2011 07:57:28 +0000 (UTC)
Received: from CH1EHSMHS003.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.243])	by mail142-ch1.bigfish.com (Postfix) with ESMTP id
	4237A9D804F	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jun 2011 07:57:28 +0000 (UTC)
Subject: Re: [PATCH] powerpc/85xx: fix race bug of calling request_irq after
	enable elbc interrupts
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1307069111-24459-1-git-send-email-Shaohui.Xie@freescale.com>
Date: Fri, 3 Jun 2011 02:57:21 -0500
Message-ID: <74487FC2-51D0-4E63-8A85-8B05E8E119A6@freescale.com>
References: <1307069111-24459-1-git-send-email-Shaohui.Xie@freescale.com>
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 2, 2011, at 9:45 PM, Shaohui Xie wrote:

> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/sysdev/fsl_lbc.c |    6 +++---
> 1 files changed, 3 insertions(+), 3 deletions(-)

applied to merge

- k
