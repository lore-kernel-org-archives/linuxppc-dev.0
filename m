Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYn6c3FK8zDqCX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 22:27:20 +1000 (AEST)
In-Reply-To: <20160617052517.25322-1-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/pci: Fix SRIOV not building without EEH enabled
Message-Id: <3rYn6c10Spz9t0Q@ozlabs.org>
Date: Tue, 21 Jun 2016 22:27:19 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-17-06 at 05:25:17 UTC, Russell Currey wrote:
> On Book3E CPUs (and possibly other configs), it is possible to have SRIOV
> (CONFIG_PCI_IOV) set without CONFIG_EEH.  The SRIOV code does not check
> for this, and if EEH is disabled, pci_dn.c fails to build.
> 
> Fix this by gating the EEH-specific code in the SRIOV implementation
> behind CONFIG_EEH.
> 
> Fixes: 39218cd0 ("powerpc/eeh: EEH device for VF")
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fb36e90736938d50fdaa1be7af

cheers
