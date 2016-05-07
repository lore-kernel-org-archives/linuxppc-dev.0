Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1wDn1r9hzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 May 2016 14:11:05 +1000 (AEST)
In-Reply-To: <20160506115037.26330.88961.stgit@hbathini.in.ibm.com>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [2/3] powerpc/fadump: add support to specify memory range based
 size
Message-Id: <3r1wDn0JV0z9t3k@ozlabs.org>
Date: Sat,  7 May 2016 14:11:05 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-06-05 at 11:50:37 UTC, Hari Bathini wrote:
> Currently, memory for fadump can be specified with fadump_reserve_mem=size,
> where only a fixed size can be specified. This patch tries to extend this
> syntax to support conditional reservation based on memory size, with the
> below syntax:
> 
> 	fadump_reserve_mem=<range1>:<size1>[,<range2>:<size2>,...]
> 
> This syntax helps using the same commandline parameter for different system
> memory sizes.

This is basically using the crashkernel= syntax right?

So can we please reuse the crashkernel= parsing code?

cheers
