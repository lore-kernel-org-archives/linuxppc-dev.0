Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 894551A034A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:41:31 +1100 (AEDT)
In-Reply-To: <1454904500-11218-1-git-send-email-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [V3] powerpc/powernv: Remove support for p5ioc2
Message-Id: <20160217124131.3E1D6140770@ozlabs.org>
Date: Wed, 17 Feb 2016 23:41:31 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-08-02 at 04:08:20 UTC, Russell Currey wrote:
> "p5ioc2 is used by approximately 2 machines in the world, and has never
> ever been a supported configuration."
> 
> The code for p5ioc2 is essentially unused and complicates what is already
> a very complicated codebase.  Its removal is essentially a "free win" in
> the effort to simplify the powernv PCI code.
> 
> In addition, support for p5ioc2 has been dropped from skiboot.  There's no
> reason to keep it around in the kernel.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2de50e9674fc4ca3c6174b0447

cheers
