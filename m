Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPxBg068bzDvwy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 11:04:11 +1100 (AEDT)
In-Reply-To: <1479562934-1541-1-git-send-email-lars@metafoo.de>
To: Lars-Peter Clausen <lars@metafoo.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: ibmebus: Remove legacy suspend/resume support
Message-Id: <3tPxBf4pPwz9t3K@ozlabs.org>
Date: Fri, 25 Nov 2016 11:04:10 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-11-19 at 13:42:14 UTC, Lars-Peter Clausen wrote:
> There are no ibmebus driver that make use of legacy suspend/resume. This
> patch removes the support for it from ibmebus framework, new ibmebus driver
> (as unlikely as they are) wanting to use suspend/resume should use
> dev_pm_ops.
> 
> Since there aren't any special bus specific things to do during
> suspend/resume and since the PM core will automatically fallback directly
> to using the device's PM ops if no bus PM ops are specified there is no
> need to have any special ibmebus PM ops at all.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8004ca995c24a078ae362f6dd9f8e1

cheers
