Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvgvR1NspzDqK1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 23:35:31 +1100 (AEDT)
In-Reply-To: <1490588387-18903-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: bamvor.zhangjian@linaro.org, aneesh.kumar@linux.vnet.ibm.com,
 linux-kselftest@vger.kernel.org, shuahkh@osg.samsung.com
Subject: Re: selftests/powerpc: Fix standalone powerpc build
Message-Id: <3vvgvQ3mb7z9s0g@ozlabs.org>
Date: Fri, 31 Mar 2017 23:35:30 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-03-27 at 04:19:47 UTC, Michael Ellerman wrote:
> The changes to enable building with a separate output directory, in
> commit a8ba798bc8ec ("selftests: enable O and KBUILD_OUTPUT") broke
> building the powerpc selftests on their own, eg:
> 
>  $ cd tools/testing/selftests/powerpc; make
> 
> It was partially fixed in commit e53aff45c490 ("selftests: lib.mk Fix
> individual test builds"), which defined OUTPUT for standalone tests. But
> that only defines OUTPUT within the Makefile, the value is not exported
> so sub-shells can't see it. We could export OUTPUT, but it's actually
> cleaner to just expand the value of OUTPUT before we invoke the shell.
> 
> Fixes: a8ba798bc8ec ("selftests: enable O and KBUILD_OUTPUT")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/2db2c250dd3d1e74a50d4ab5f44c44

cheers
