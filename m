Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdQ6l3k37zDqYY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 18:25:51 +1100 (AEDT)
In-Reply-To: <20170226060834.91303.20851.sendpatchset@Sachins-MacBook-Pro.local>
To: Sachin Sant <sachinp@linux.vnet.ibm.com>, linux-kselftest@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 shuahkh@osg.samsung.com
Subject: Re: [RESEND] selftest/powerpc/alignment: Fix false failures for
 skipped tests
Message-Id: <3vdQ6l34whz9sN5@ozlabs.org>
Date: Wed,  8 Mar 2017 18:25:51 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-02-26 at 06:08:39 UTC, Sachin Sant wrote:
> Tests under alignment subdirectory are skipped when executed on previous
> generation hardware, but harness still marks them as failed.
> 
> test: test_copy_unaligned
> tags: git_version:unknown
> [SKIP] Test skipped on line 26
> skip: test_copy_unaligned
> selftests: copy_unaligned [FAIL]
> 
> The MAGIC_SKIP_RETURN_VALUE value assigned to rc variable is retained till
> the program exit which causes the test to be marked as failed.
> 
> This patch resets the value before returning to the main() routine.
> With this patch the test o/p is as follows:
> 
> test: test_copy_unaligned
> tags: git_version:unknown
> [SKIP] Test skipped on line 26
> skip: test_copy_unaligned
> selftests: copy_unaligned [PASS]
> 
> Signed-off-by: Sachin Sant <sachinp@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/a6d8a21596df041f36f4c2ccc260c4

cheers
