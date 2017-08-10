Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSn1p6J3HzDqs4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 22:07:10 +1000 (AEST)
In-Reply-To: <1502276275-13639-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: powerpc/configs: Re-enable HARD/SOFT lockup detectors
Message-Id: <3xSn1p3K0Yz9t30@ozlabs.org>
Date: Thu, 10 Aug 2017 22:07:10 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-09 at 10:57:55 UTC, Michael Ellerman wrote:
> In commit 05a4a9527931 ("kernel/watchdog: split up config options"),
> CONFIG_LOCKUP_DETECTOR was split into two separate config options,
> CONFIG_HARDLOCKUP_DETECTOR and CONFIG_SOFTLOCKUP_DETECTOR.
> 
> Our defconfigs still have CONFIG_LOCKUP_DETECTOR=y, but that is no longer
> user selectable, and we don't mention the new options, so we end up with
> none of them enabled.
> 
> So update the defconfigs to turn on the new SOFT and HARD options, the
> end result being the same as what we had previously.
> 
> Fixes: 05a4a9527931 ("kernel/watchdog: split up config options")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/7310d5c8c55e8987a854507f71022f

cheers
