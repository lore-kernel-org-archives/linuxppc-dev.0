Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Ln4Z6yfKzF1Rd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 00:49:34 +1000 (AEST)
In-Reply-To: <20180410114933.24581-4-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [3/3] powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops
Message-Id: <40Ln4Z68p4z9s3X@ozlabs.org>
Date: Thu, 12 Apr 2018 00:49:34 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-04-10 at 11:49:33 UTC, Nicholas Piggin wrote:
> The OPAL NVRAM driver does not sleep in case it gets OPAL_BUSY or
> OPAL_BUSY_EVENT from firmware, which causes large scheduling
> latencies, and various lockup errors to trigger (again, BMC reboot
> can cause it).
> 
> Fix this by converting it to the standard form OPAL_BUSY loop that
> sleeps.
> 
> Fixes: 628daa8d5abfd ("powerpc/powernv: Add RTC and NVRAM support plus RTAS fallbacks")
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/3b8070335f751aac9f1526ae2e012e

cheers
