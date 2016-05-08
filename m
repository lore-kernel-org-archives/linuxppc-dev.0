Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r2Wx26sGTzDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 May 2016 13:59:34 +1000 (AEST)
In-Reply-To: <1461835870-67778-4-git-send-email-chandan.kumar@linux.vnet.ibm.com>
To: Chandan Kumar <chandan.kumar@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: maddy@linux.vnet.ibm.com, acme@redhat.com, hemant@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, jolsa@redhat.com
Subject: Re: [3/3] perf tools: Fix perf regs mask generation
Message-Id: <3r2Wx26Hdtz9t0r@ozlabs.org>
Date: Sun,  8 May 2016 13:59:34 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-28-04 at 09:31:10 UTC, Chandan Kumar wrote:
> From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> 
> On some architectures (powerpc in particular), the number of registers
> exceeds what can be represented in an integer bitmask. Ensure we
> generate the proper bitmask on such platforms.
> 
> Fixes: 71ad0f5e4 ("perf tools: Support for DWARF CFI unwinding on post
> processing")
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/826dccfd238c3eeac379f5f637

cheers
