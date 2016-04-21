Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrKbk1g0gzDqdZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 23:39:14 +1000 (AEST)
In-Reply-To: <1455944568-7231-5-git-send-email-anju@linux.vnet.ibm.com>
To: Anju T <anju@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, acme@redhat.com,
 hemant@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, dsahern@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com, jolsa@redhat.com
Subject: Re: [V2,4/4] tool/perf: Add sample_reg_mask to include all perf_regs
Message-Id: <3qrKbj0Llbz9t6X@ozlabs.org>
Date: Thu, 21 Apr 2016 23:39:12 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-20-02 at 05:02:48 UTC, Anju T wrote:
> From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> 
> Add sample_reg_mask array with pt_regs registers.
> This is needed for printing supported regs ( -I? option).
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bb62bad623deb7952aef13fcbe

cheers
