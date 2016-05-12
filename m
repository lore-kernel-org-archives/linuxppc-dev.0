Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r59p05Q3SzDqDV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 21:32:40 +1000 (AEST)
In-Reply-To: <1461719696-28044-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [v3,
 1/4] powerpc/eeh: Don't report error in eeh_pe_reset_and_recover()
Message-Id: <3r59p01Mj8z9s5J@ozlabs.org>
Date: Thu, 12 May 2016 21:32:39 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-27-04 at 01:14:50 UTC, Gavin Shan wrote:
> The function eeh_pe_reset_and_recover() is used to recover EEH
> error when the passthrough device are transferred to guest and
> backwards, meaning the device's driver is vfio-pci or none.
> When the driver is vfio-pci that provides error_detected() error
> handler only, the handler simply stops the guest and it's not
> expected behaviour. On the other hand, no error handlers will
> be called if we don't have a bound driver.
> 
> This ignores the error handler in eeh_pe_reset_and_recover()
> that reports the error to device driver to avoid the exceptional
> behaviour.
> 
> Fixes: 5cfb20b9 ("powerpc/eeh: Emulate EEH recovery for VFIO devices")
> Cc: stable@vger.kernel.org #v3.18+
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: Russell Currey <ruscur@russell.cc>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/affeb0f2d3a9af419ad7ef4ac7

cheers
