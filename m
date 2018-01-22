Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxql14nqzF0X1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:11 +1100 (AEDT)
In-Reply-To: <20171116160052.18672-5-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [4/4] cpuidle/powernv: avoid double irq enable coming out of idle
Message-Id: <3zPxqk2LSvz9s9Y@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:09 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-11-16 at 16:00:52 UTC, Nicholas Piggin wrote:
> Since e1689795a7 ("cpuidle: Add common time keeping and irq enabling"),
> cpuidle drivers are expected to return from ->enter with irqs disabled.
> 
> Update the cpuidle-powernv snooze and cede loops to disable irqs before
> returning.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ced54c08d8e4060d59c10629ea5a4c

cheers
