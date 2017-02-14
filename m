Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN27v4bwFzDqy4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 23:40:27 +1100 (AEDT)
In-Reply-To: <1486544251-11292-1-git-send-email-anju@linux.vnet.ibm.com>
To: Anju T <anju@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, anju@linux.vnet.ibm.com,
 paulus@samba.org, mhiramat@kernel.org, naveen.n.rao@linux.vnet.ibm.com,
 hemant@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com
Subject: Re: [1/3] powerpc: asm/ppc-opcode.h: introduce __PPC_SH64()
Message-Id: <3vN27v1xBWz9s6s@ozlabs.org>
Date: Tue, 14 Feb 2017 23:40:27 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-02-08 at 08:57:29 UTC, Anju T wrote:
> From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> 
> Introduce __PPC_SH64() as a 64-bit variant to encode shift field in some
> of the shift and rotate instructions operating on double-words. Convert
> some of the BPF instruction macros to use the same.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c233f5979b3dbb39a5b2473b5fcaf5

cheers
