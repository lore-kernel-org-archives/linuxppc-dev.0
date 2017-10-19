Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHbzD5vZvzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 15:48:24 +1100 (AEDT)
In-Reply-To: <20171009175627.4829-1-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Alastair D'Silva <alastair@au1.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: cxl: Rename register PSL9_FIR2 to PSL9_FIR_MASK
Message-Id: <3yHbzD3Mygz9tXK@ozlabs.org>
Date: Thu, 19 Oct 2017 15:48:24 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-10-09 at 17:56:27 UTC, Vaibhav Jain wrote:
> PSL9 doesn't have a FIR2 register as was the case with PSL8. However
> currently the register definitions in 'cxl.h' have a definition for
> PSL9_FIR2 that actually points to PSL9_FIR_MASK register in the P1
> area at offset 0x308.
> 
> So this patch renames the def PSL9_FIR2 to PSL9_FIR_MASK and updates
> the references in the code to point to the new identifier. It also
> removes the code to dump contents of FIR2 (FIR_MASK actually) in
> cxl_native_irq_dump_regs_psl9().
> 
> Fixes: f24be42aab37("cxl: Add psl9 specific code")
> Reported-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8f6a90421c7637984fb352da079fb1

cheers
