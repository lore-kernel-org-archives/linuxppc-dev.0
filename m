Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 80D0A1A067C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 22:10:54 +1100 (AEDT)
In-Reply-To: <1443681874-28145-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [1/4] powerpc/pseries: Make PCI non-optional
Message-Id: <20151015111054.45C5D1402D6@ozlabs.org>
Date: Thu, 15 Oct 2015 22:10:54 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-01-10 at 06:44:31 UTC, Michael Ellerman wrote:
> The pseries build with PCI=n looks to have been broken for at least 5
> years, and no one's noticed or cared.
> 
> Following the obvious breakages backward, the first commit I can find
> that builds is the parent of 2eb4afb69ff3 ("powerpc/pci: Move pseries
> code into pseries platform specific area") from April 2009.
> 
> A distro would never ship a PCI=n kernel, so it is only useful for folks
> building custom kernels. Also on KVM the virtio devices appear on PCI,
> so it would only be useful if you were building kernels specifically to
> run on PowerVM and with no PCI devices.
> 
> The added code complexity, and testing load (which we've clearly not
> been doing), is not justified by the small reduction in kernel size for
> such a niche use case.
> 
> So just make PCI non-optional on pseries.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/4c9cd468b348c9e47f9380a5

cheers
