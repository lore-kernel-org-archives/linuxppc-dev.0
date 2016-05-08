Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r2Wx14ShGzDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 May 2016 13:59:33 +1000 (AEST)
In-Reply-To: <1461835870-67778-2-git-send-email-chandan.kumar@linux.vnet.ibm.com>
To: Chandan Kumar <chandan.kumar@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: maddy@linux.vnet.ibm.com, Chandan Kumar <chandan.kumar@linux.vnet.ibm.com>,
 acme@redhat.com, hemant@linux.vnet.ibm.com, anju@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, jolsa@redhat.com
Subject: Re: [1/3] powerpc: Add HAVE_PERF_USER_STACK_DUMP support
Message-Id: <3r2Wx13LdYz9sdQ@ozlabs.org>
Date: Sun,  8 May 2016 13:59:33 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-28-04 at 09:31:08 UTC, Chandan Kumar wrote:
> With perf regs support enabled for powerpc, the support for obtaining
> perf user stack dump is already enabled.
> This patch declares the support for same and also updates documentation
> to mark the support for perf-regs and perf-stackdump.
> 
> Signed-off-by: Chandan Kumar <chandan.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/08c1f9ec28d2d156aca29f7752

cheers
