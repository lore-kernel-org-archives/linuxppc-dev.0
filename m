Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7sRx2fFVzDqf4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 21:26:37 +1000 (AEST)
In-Reply-To: <1469178096-8510-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: felix@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com, imunsie@au1.ibm.com,
 fbarrat@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com
Subject: Re: cxl: fix sparse warnings
Message-Id: <3s7sRx1km0z9t1Q@ozlabs.org>
Date: Tue,  9 Aug 2016 21:26:37 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-22-07 at 09:01:36 UTC, Andrew Donnellan wrote:
> Make native_irq_wait() static and use NULL rather than 0 to initialise
> phb->cfg_data in cxl_pci_vphb_add() to remove sparse warnings.
> 
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/6fd40f192a9dba391b2d84882f

cheers
