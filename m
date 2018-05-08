Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gMsg4G77zF15H
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 00:52:39 +1000 (AEST)
In-Reply-To: <152481017041.9024.9087742951572073802.stgit@jupiter.in.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/fadump: Unregister fadump on kexec down path.
Message-Id: <40gMsf4slPz9s4s@ozlabs.org>
Date: Wed,  9 May 2018 00:52:38 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-04-27 at 06:23:18 UTC, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> Unregister fadump on kexec down path otherwise the fadump registration in
> new kexec-ed kernel complains that fadump is already registered. This
> makes new kernel to continue using fadump registered by previous kernel
> which may lead to invalid vmcore generation. Hence this patch fixes this
> issue by un-registering fadump in fadump_cleanup() which is called during
> kexec path so that new kernel can register fadump with new valid values.
> 
> Fixes: b500afff11f6 ("fadump: Invalidate registration and release reserved memory for general use.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/722cde76d68e8cc4f3de42e71c82fd

cheers
