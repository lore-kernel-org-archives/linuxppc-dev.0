Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8frr5f6JzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 11:33:00 +1100 (AEDT)
In-Reply-To: <1484781016-13379-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: #3.18+@gwshan.ozlabs.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 stable@vger.kernel.org
Subject: Re: [v2] powerpc/eeh: Fix wrong flag passed to eeh_unfreeze_pe()
Message-Id: <3v8frr4x7Rz9t0t@ozlabs.org>
Date: Fri, 27 Jan 2017 11:33:00 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-01-18 at 23:10:16 UTC, Gavin Shan wrote:
> In __eeh_clear_pe_frozen_state(), we should pass the flag's value
> instead of its address to eeh_unfreeze_pe(). The isolated flag is
> cleared if no error returned from __eeh_clear_pe_frozen_state().
> We never observed the error from the function. So the isolated flag
> should have been always cleared, no real issue is caused because
> of the misused @flag.
> 
> This fixes the code by passing the value of @flag to eeh_unfreeze_pe().
> 
> Cc: stable@vger.kernel.org #3.18+
> Fixes: 5cfb20b96f6 ("powerpc/eeh: Emulate EEH recovery for VFIO devices")
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/f05fea5b3574a5926c53865eea2713

cheers
