Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0104.outbound.protection.outlook.com [207.46.100.104])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E6091A02B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 08:49:50 +1100 (AEDT)
Message-ID: <1413496162.7417.9.camel@aoeu.buserror.net>
Subject: Re: [PATCH 0/2] fix a kernel panic on fsl corenet board when
 CONFIG_CLK_PPC_CORENET is enabled
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Thu, 16 Oct 2014 23:49:22 +0200
In-Reply-To: <1413458321-23880-1-git-send-email-haokexin@gmail.com>
References: <1413458321-23880-1-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Jingchang Lu <jingchang.lu@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Mike Turquette <mturquette@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-10-16 at 19:18 +0800, Kevin Hao wrote:
> Hi,
> 
> This tries to fix a kernel panic introduced by commit da788acb2838
> ("clk: ppc-corenet: Fix Section mismatch warning").

That patch is just wrong and should be reverted, separately from any new
attempt to fix the section mismatch warning.

-Scott
