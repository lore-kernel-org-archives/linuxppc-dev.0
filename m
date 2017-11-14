Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yblG45hqKzDqpb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 22:12:12 +1100 (AEDT)
In-Reply-To: <1509564221-7049-1-git-send-email-gromero@linux.vnet.ibm.com>
To: Gustavo Romero <gromero@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: leitao@debian.org, cyrilbur@gmail.com
Subject: Re: selftests/powerpc: Check FP/VEC on exception in TM
Message-Id: <3yblG450fHz9sPs@ozlabs.org>
Date: Tue, 14 Nov 2017 22:12:12 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-11-01 at 19:23:41 UTC, Gustavo Romero wrote:
> Add a self test to check if FP/VEC/VSX registers are sane (restored
> correctly) after a FP/VEC/VSX unavailable exception is caught during a
> transaction.
> 
> This test checks all possibilities in a thread regarding the combination
> of MSR.[FP|VEC] states in a thread and for each scenario raises a
> FP/VEC/VSX unavailable exception in transactional state, verifying if
> vs0 and vs32 registers, which are representatives of FP/VEC/VSX reg
> sets, are not corrupted.
> 
> Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/77fad8bfb1d2f8225b05e4ea344578

cheers
