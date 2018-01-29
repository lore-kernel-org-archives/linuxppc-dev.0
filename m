Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVGNC13HfzDqmV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 15:13:47 +1100 (AEDT)
In-Reply-To: <1507783474-28210-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: [1/3] powerpc/watchdog: Tweak watchdog printks
Message-Id: <3zVGN96V9nz9s7n@ozlabs.org>
Date: Mon, 29 Jan 2018 15:13:45 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-10-12 at 04:44:32 UTC, Michael Ellerman wrote:
> Use pr_fmt() in the watchdog code, so we don't have to say "Watchdog"
> so many times.
> 
> Rather than "CPU:%d" just spell it "CPU %d", "Hard" doesn't need a
> capital in the middle of a sentence, and "LOCKUP other CPUS" should be
> "LOCKUP on other CPUS".
> 
> Also make it clear when a CPU self detects a lockup by spelling it
> out.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/d8fa82e0e2b1ad9c66aa76810615ad

cheers
