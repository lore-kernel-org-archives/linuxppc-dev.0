Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4CYc4CrRzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 07:48:36 +1000 (AEST)
In-Reply-To: <1462254105-24128-2-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: aik@ozlabs.ru, alistair@popple.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [v9,01/26] powerpc/pci: Cleanup on struct pci_controller_ops
Message-Id: <3r4CYc3G14z9t45@ozlabs.org>
Date: Wed, 11 May 2016 07:48:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-03-05 at 05:41:20 UTC, Gavin Shan wrote:
> Each PHB has one instance of "struct pci_controller_ops" that includes
> various callbacks called by PCI subsystem. In the definition of this
> struct, some callbacks have explicit names for its arguments, but the
> left don't have.
> 
> This adds all explicit names of the arguments to the callbacks in
> "struct pci_controller_ops" so that the code looks consistent. Also,
> argument name @dev is replaced by @pdev as the later one is the
> preferred name for PCI device.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: Daniel Axtens <dja@axtens.net>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ec73f9a8dfdfce0112ee041705

cheers
