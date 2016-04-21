Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrKbf0tQrzDqdX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 23:39:10 +1000 (AEST)
In-Reply-To: <1455944568-7231-3-git-send-email-anju@linux.vnet.ibm.com>
To: Anju T <anju@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, acme@redhat.com,
 hemant@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, dsahern@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com, jolsa@redhat.com
Subject: Re: [V11,
 2/4] perf/powerpc: add support for sampling intr machine state
Message-Id: <3qrKbf0F5tz9t5V@ozlabs.org>
Date: Thu, 21 Apr 2016 23:39:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-20-02 at 05:02:46 UTC, Anju T wrote:
> The perf infrastructure uses a bit mask to find out valid
> registers to display. Define a register mask for supported
> registers defined in asm/perf_regs.h. The bit positions also
> correspond to register IDs which is used by perf infrastructure
> to fetch the register values. CONFIG_HAVE_PERF_REGS enables
> sampling of the interrupted machine state.
> 
> Signed-off-by: Anju T <anju@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ed4a4ef85cf5b7523107950103

cheers
