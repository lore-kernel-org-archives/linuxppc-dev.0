Return-Path: <mturquette@linaro.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5FD2C1A0D4A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Jan 2015 06:32:41 +1100 (AEDT)
Received: by mail-pa0-f45.google.com with SMTP id lf10so30642891pab.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jan 2015 11:32:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Kevin Hao <haokexin@gmail.com>, "Scott Wood" <scottwood@freescale.com>
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <20141209013415.GB20874@pek-khao-d1.corp.ad.wrs.com>
References: <1417596833-31456-1-git-send-email-haokexin@gmail.com>
 <1417596833-31456-2-git-send-email-haokexin@gmail.com>
 <1417751519.334.9.camel@freescale.com>
 <20141209013415.GB20874@pek-khao-d1.corp.ad.wrs.com>
Message-ID: <20150117193230.22722.72503@quantum>
Subject: Re: [PATCH v3 1/3] Revert "clk: ppc-corenet: Fix Section mismatch
 warning"
Date: Sat, 17 Jan 2015 11:32:30 -0800
Cc: Yuantian Tang <Yuantian.Tang@freescale.com>, Gerhard Sittig <gsi@denx.de>,
 linuxppc-dev@lists.ozlabs.org, Jingchang Lu <jingchang.lu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Kevin Hao (2014-12-08 17:34:15)
> On Thu, Dec 04, 2014 at 09:51:59PM -0600, Scott Wood wrote:
> > This patch is going to conflict with commit a4ae8f3b0f7ac6ab3 "clk: drop
> > owner assignment from platform_drivers" in linux-next -- or rather,
> > you've based this on that patch, but it's not in mpe's next branch, so I
> > get a merge conflict and there'd be another merge conflict later on to
> > get back to the newer base.
> > =

> > I really think this should go via the clock tree.  That's where the
> > breakage was introduced in the first place...
> =

> Hi Mike,
> =

> Could you pick up these patches?

Kevin,

I've taken patch #1 into clk-fixes (will be sent out later today) and
patches #2 & #3 into clk-next towards 3.20.

Regards,
Mike

> =

> Thanks,
> Kevin
