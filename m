Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrTtr4YyDzDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 20:53:08 +1000 (AEST)
In-Reply-To: <1468444634-1866-2-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Huy Nguyen <huyn@mellanox.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [01/15] powerpc/powernv: Split cxl code out into a separate file
Message-Id: <3rrTtr3fZ8z9sBg@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:08 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-13-07 at 21:17:00 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> The support for using the Mellanox CX4 in cxl mode will require
> additions to the PHB code. In preparation for this, move the existing
> cxl code out of pci-ioda.c into a separate pci-cxl.c file to keep things
> more organised.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f456834a6c1db36c290fdfe8ab

cheers
