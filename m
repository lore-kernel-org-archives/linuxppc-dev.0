Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WNpb2y55zDqDJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 16:07:35 +1000 (AEST)
In-Reply-To: <1524636895-27185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, rjw@rjwysocki.net,
 viresh.kumar@linaro.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: cpufreq: powernv: Remove global pstate ramp-down timer in POWER9
Message-Id: <41WNpb24Jbz9s21@ozlabs.org>
Date: Thu, 19 Jul 2018 16:07:35 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-04-25 at 06:14:55 UTC, Shilpasri G Bhat wrote:
> POWER9 doesnot support global pstate requests for the chip. So remove
> the timer logic which slowly ramps down the global pstate in P9
> platforms.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/dcb14337e0f2adb227c376e6327ef0

cheers
