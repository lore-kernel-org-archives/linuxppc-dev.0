Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hZlg5xz0zF2CH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 00:06:39 +1000 (AEST)
In-Reply-To: <20180505072600.13270-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v2,
 1/2] powerpc/watchdog: don't update the watchdog timestamp if a
 lockup is detected
Message-Id: <40hZlf3p8pz9s0W@ozlabs.org>
Date: Fri, 11 May 2018 00:06:37 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2018-05-05 at 07:25:59 UTC, Nicholas Piggin wrote:
> The watchdog heartbeat timestamp is updated when the local heartbeat
> timer fires (or touch_nmi_watchdog() is called).
> 
> This is an interesting data point, so don't overwrite it when the
> soft-NMI interrupt detects a hard lockup. That code came from a pre-
> merge version to prevent hard lockup messages flood, but that's taken
> care of with the stuck CPU logic now, so there is no reason to
> update the heartbeat timestamp here.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5a951c4e7e8df5d6df52bace1b4ff3

cheers
