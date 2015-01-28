Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0139.outbound.protection.outlook.com [157.56.111.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C7A61A0A40
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 09:59:59 +1100 (AEDT)
Message-ID: <1422485983.10544.97.camel@freescale.com>
Subject: Re: [PATCH v2 00/10] clk: qoriq: Add support for the FMan clock
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Wed, 28 Jan 2015 16:59:43 -0600
In-Reply-To: <54C95910.60402@Freescale.com>
References: <1421834611-9656-1-git-send-email-Emilian.Medve@Freescale.com>
 <20150128181504.22722.30981@quantum> <54C95910.60402@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, haokexin@gmail.com,
 Mike Turquette <mturquette@linaro.org>, yuantian.tang@Freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-01-28 at 15:48 -0600, Emil Medve wrote:
> Hello Mike,
> 
> 
> On 01/28/2015 12:15 PM, Mike Turquette wrote:
> > Quoting Emil Medve (2015-01-21 02:03:22)
> >> Based on clk-next from git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
> >>
> >> v2:     Rebased as several prerequisite patches (including a file rename) got
> >>         applied upstream
> >>
> >> Emil Medve (9):
> >>   clk: qoriq: Fix checkpatch type PARENTHESIS_ALIGNMENT
> >>   clk: qoriq: Fix checkpatch type ALLOC_WITH_MULTIPLY
> >>   clk: qoriq: Fix checkpatch type ALLOC_SIZEOF_STRUCT
> >>   clk: qoriq: Fix checkpatch type OOM_MESSAGE
> >>   clk: qoriq: Make local symbol 'static'
> >>   clk: qoriq: Replace kzalloc() with kmalloc()
> >>   clk: qoriq: Use pr_fmt()
> > 
> > Patches 1-7 applied to clk-next towards 3.20
> 
> Thank you
> 
> > I'd prefer some
> > reviewed-by's from your peers at freescale for the clock driver
> > correctness.
> 
> That's fair
> 
> >>   powerpc/corenet: Enable CLK_QORIQ
> 
> I was thinking Scott can pick this up

Not if the patch that introduces CLK_QORIQ goes in via another tree.

> >> Igal Liberman (1):
> >>   clk: qoriq: Add support for the FMan clock
> 
> Scott, I'd appreciate your help here

>From internal discussion I believe you have some comments of your own on
this patch...

-Scott
