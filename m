Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wx6fs1YFHzDr1k
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 21:44:53 +1000 (AEST)
In-Reply-To: <1497368465-13104-1-git-send-email-clombard@linux.vnet.ibm.com>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [V3] cxl: Fixes for Coherent Accelerator Interface Architecture
 2.0
Message-Id: <3wx6fs0rJBz9s87@ozlabs.org>
Date: Mon, 26 Jun 2017 21:44:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-06-13 at 15:41:05 UTC, Christophe Lombard wrote:
> A previous set of patches "cxl: Add support for Coherent Accelerator
> Interface Architecture 2.0" has introduced a new support for the CAPI
> cards. These patches have been tested on Simulation environment and
> quite a bit of them have been tested on real hardware.
> 
> This patch brings new fixes after a series of tests carried out on
> new equipment:
> * Add POWER9 definition.
> * Re-enable any masked interrupts when the AFU is not activated after
>   resetting the AFU.
> * Remove the api cxl_is_psl8/9 which is no longer useful.
> * Do not dump CAPI1 registers.
> * Rewrite cxl_is_page_fault() function.
> * Do not register slb callack on P9.
> 
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/797625deaedd9a0621376817db2813

cheers
