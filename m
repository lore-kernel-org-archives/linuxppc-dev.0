Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0141.outbound.protection.outlook.com [65.55.169.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2DD031A0C90
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 12:10:32 +1100 (AEDT)
Message-ID: <1417741817.334.7.camel@freescale.com>
Subject: Re: [PATCH v3 1/3] Revert "clk: ppc-corenet: Fix Section mismatch
 warning"
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Thu, 4 Dec 2014 19:10:17 -0600
In-Reply-To: <20141204060652.GC14597@pek-khao-d1.corp.ad.wrs.com>
References: <1417596833-31456-1-git-send-email-haokexin@gmail.com>
 <1417596833-31456-2-git-send-email-haokexin@gmail.com>
 <1417665891.15957.238.camel@freescale.com>
 <20141204043816.GB14597@pek-khao-d1.corp.ad.wrs.com>
 <1417668384.15957.240.camel@freescale.com>
 <20141204060652.GC14597@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Mike Turquette <mturquette@linaro.org>, Gerhard Sittig <gsi@denx.de>,
 Yuantian Tang <Yuantian.Tang@freescale.com>,
 Jingchang Lu <jingchang.lu@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-12-04 at 14:06 +0800, Kevin Hao wrote:
> On Wed, Dec 03, 2014 at 10:46:24PM -0600, Scott Wood wrote:
> > Since only this first patch is a critical bugfix, and there's no
> > arch/powerpc content in that patch, I think it should go via Mike's tree
> > if it's to go in for 3.18 (if it's not already too late).  Or, to keep
> > things simple given the dependency of the following patches, we could
> > batch them all together for -next and add a # 3.18 stable request.
> 
> We don't need to explicitly add a #3.18 stable request in this case. As I know,
> we only need to indicate the first version which is affected by the bug fixed by
> this commit in the cc tag. This would imply that the applicable stable kernel
> version rang should be from 3.17 to the previous version of the kernel which
> finally merge this commit.

OK.

-Scott
