Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 344B71A005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 09:14:16 +1000 (AEST)
In-Reply-To: <20150511082343.31385.39300.stgit@hbathini.in.ibm.com>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: nvram: print no error message when nvram is not set as pstore
 backend
Message-Id: <20150819231415.89E9A14076C@ozlabs.org>
Date: Thu, 20 Aug 2015 09:14:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-11-05 at 08:23:43 UTC, Hari Bathini wrote:
> Pstore only supports one backend at a time. The preferred
> pstore backend is set by passing the pstore.backend=<name>
> argument to the kernel at boot time. Currently, while trying
> to register with pstore, nvram throws an error message even
> when "pstore.backend != nvram", which is unnecessary. This
> patch removes the error message in case "pstore.backend != nvram".
> 
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/74943dab6b155b1a9d40

cheers
