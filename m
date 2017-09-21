Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyKGW01cNzDqTc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 11:46:43 +1000 (AEST)
In-Reply-To: <1503466686-10932-34-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [33/46] powerpc/configs: Update for CONFIG_SND changes
Message-Id: <3xyKGV6NzJz9sBZ@ozlabs.org>
Date: Thu, 21 Sep 2017 11:46:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-23 at 05:37:53 UTC, Michael Ellerman wrote:
> Commit eb3b705aaed9 ("ALSA: Make CONFIG_SND_OSSEMUL user-selectable")
> means we need to set CONFIG_SND_OSSEMUL in our configs, otherwise we
> lose some of the SND symbols.
> 
> And commit 0181307abc1d ("ALSA: seq: Reorganize kconfig and build")
> reorganised things, which causes the churn.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/8632ec8cdcaead67c019f1ba36760d

cheers
