Return-Path: <B11780@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 03481B71C8
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 14:52:40 +1000 (EST)
Received: from mail12-va3 (localhost.localdomain [127.0.0.1])	by
	mail12-va3-R.bigfish.com (Postfix) with ESMTP id C4CADAE00DB	for
	<linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 04:52:36 +0000 (UTC)
Received: from VA3EHSMHS031.bigfish.com (unknown [10.7.14.245])	by
	mail12-va3.bigfish.com (Postfix) with ESMTP id 969871940046	for
	<linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 04:52:36 +0000 (UTC)
Subject: Re: [PATCH] Powerpc/fsl_lbc: Add workaround for ELBC-A001 erratum
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1305802081-19733-1-git-send-email-Shengzhou.Liu@freescale.com>
Date: Thu, 19 May 2011 23:52:33 -0500
Message-ID: <330922C6-7E65-4757-A69A-A9C66E90E39E@freescale.com>
References: <1305802081-19733-1-git-send-email-Shengzhou.Liu@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 19, 2011, at 5:48 AM, Shengzhou Liu wrote:

> Simultaneous FCM and GPCM or UPM operation may erroneously trigger
> bus monitor timeout.
> 
> Set the local bus monitor timeout value to the maximum by setting
> LBCR[BMT] = 0 and LBCR[BMTPS] = 0xF.
> 
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> Signed-off-by: Gala Kumar <kumar.gala@freescale.com>
> ---
> arch/powerpc/include/asm/fsl_lbc.h |    2 ++
> arch/powerpc/sysdev/fsl_lbc.c      |    9 +++++++--
> 2 files changed, 9 insertions(+), 2 deletions(-)

applied to next

- k
