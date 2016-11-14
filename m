Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHTzp3NHpzDvll
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:17:26 +1100 (AEDT)
In-Reply-To: <20160927141016.6027-1-rui.teng@linux.vnet.ibm.com>
To: Rui Teng <rui.teng@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, Anton Blanchard <anton@au1.ibm.com>,
 Rui Teng <rui.teng@linux.vnet.ibm.com>, Shuah Khan <shuah@kernel.org>,
 Cyril Bur <cyrilbur@gmail.com>
Subject: Re: tools/testing/selftests/powerpc: Add Anton's null_syscall
 benchmark to the selftests
Message-Id: <3tHTzp2PWzz9t1h@ozlabs.org>
Date: Mon, 14 Nov 2016 23:17:26 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-27-09 at 14:10:16 UTC, Rui Teng wrote:
> From: Anton Blanchard <anton@au.ibm.com>
> 
> Pull in a version of Anton's null_syscall benchmark:
> http://ozlabs.org/~anton/junkcode/null_syscall.c
> Into tools/testing/selftests/powerpc/benchmarks.
> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Anton Blanchard <anton@au.ibm.com>
> Signed-off-by: Rui Teng <rui.teng@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d8db9bc55a316d97d0acdf6ccc9f43

cheers
