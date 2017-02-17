Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPqy96dmPzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 22:08:17 +1100 (AEDT)
Message-ID: <1487329688.2944.0.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Fri, 17 Feb 2017 05:08:08 -0600
In-Reply-To: <20170127235348.GA21260@home.buserror.net>
References: <20170127235348.GA21260@home.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Pull request: scottwood/linux.git next
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-01-27 at 17:53 -0600, Scott Wood wrote:
> Highlights include 8xx breakpoints and perf, t1042rdb display support,
> and board updates.
> 
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next
> 
> for you to fetch changes up to 75b824727680a9d12c34d78096a5ac642e53f5d0:
> 
>   powerpc/8xx: Perf events on PPC 8xx (2017-01-26 17:49:34 -0600)
> 
> ----------------------------------------------------------------
> Christophe Leroy (4):
>       powerpc/32: Enable HW_BREAKPOINT on BOOK3S
>       powerpc/8xx: Implement hw_breakpoint
>       powerpc/32: Remove FIX_SRR1
>       powerpc/8xx: Perf events on PPC 8xx
> 
> Jason Jin (1):
>       powerpc/85xx: Enable display support for t1042rdb
> 
> Valentin Longchamp (3):
>       powerpc/corenet: explicitly disable the SDHC controller on kmcoge4
>       powerpc/85xx: remove the kmp204x_defconfig
>       powerpc/corenet: add support for the kmcent2 board

ping?

-Scott
