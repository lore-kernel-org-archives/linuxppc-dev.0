Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrKbd2mn6zDqdX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 23:39:09 +1000 (AEST)
In-Reply-To: <1455944568-7231-2-git-send-email-anju@linux.vnet.ibm.com>
To: Anju T <anju@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, acme@redhat.com,
 hemant@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, dsahern@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com, jolsa@redhat.com
Subject: Re: [V11,1/4] perf/powerpc: assign an id to each powerpc register
Message-Id: <3qrKbd1kFWz9t40@ozlabs.org>
Date: Thu, 21 Apr 2016 23:39:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-20-02 at 05:02:45 UTC, Anju T wrote:
> The enum definition assigns an 'id' to each register in "struct pt_regs"
> of arch/powerpc. The order of these values in the enum definition are
> based on the corresponding macros in arch/powerpc/include/uapi/asm/ptrace.h.
> 
> Signed-off-by: Anju T <anju@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1bfadabfebc671a6af0f5008b5

cheers
