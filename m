Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHbzF26t7zDqDF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 15:48:25 +1100 (AEDT)
In-Reply-To: <20171011061441.16795-1-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Alastair D'Silva <alastair@au1.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: [v2] cxl: Dump PSL_FIR register on PSL9 error irq
Message-Id: <3yHbzD6zL7z9tXP@ozlabs.org>
Date: Thu, 19 Oct 2017 15:48:24 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-10-11 at 06:14:41 UTC, Vaibhav Jain wrote:
> For PSL9 currently we aren't dumping the PSL FIR register when a
> PSL error interrupt is triggered. Contents of this register are useful
> in debugging AFU issues.
> 
> This patch fixes issue by adding a new service_layer_ops callback
> cxl_native_err_irq_dump_regs_psl9() to dump the PSL_FIR registers on a
> PSL error interrupt thereby bringing the behavior in line with PSL on
> POWER-8. Also the existing service_layer_ops callback
> for PSL8 has been renamed to cxl_native_err_irq_dump_regs_psl8().
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/990f19ae6feefb4a6e718355719cde

cheers
