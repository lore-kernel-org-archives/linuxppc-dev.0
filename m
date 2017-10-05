Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y702t4qPJzDr1l
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 15:21:42 +1100 (AEDT)
In-Reply-To: <20170929054410.12600-1-sandipan@linux.vnet.ibm.com>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, naveen.n.rao@linux.vnet.ibm.com,
 paulus@samba.org, anton@samba.org
Subject: Re: [1/3] powerpc/lib/sstep: Add XER bits introduced in POWER ISA v3.0
Message-Id: <3y702t31Cpz9t4X@ozlabs.org>
Date: Thu,  5 Oct 2017 15:21:42 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-09-29 at 05:44:08 UTC, Sandipan Das wrote:
> This adds definitions for the OV32 and CA32 bits of XER that
> were introduced in POWER ISA v3.0. There are some existing
> instructions that currently set the OV and CA bits based on
> certain conditions.
> 
> The emulation behaviour of all these instructions needs to
> be updated to set these new bits accordingly.
> 
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/924c8feb041c3ef22d46ac2e746816

cheers
