Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w77H911GczDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 13:47:17 +1000 (AEST)
In-Reply-To: <20170412143407.3877-1-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, andrew.donnellan@au1.ibm.com,
 imunsie@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [V4,7/7,remix] cxl: Add psl9 specific code
Message-Id: <3w77H86tgSz9s73@ozlabs.org>
Date: Wed, 19 Apr 2017 13:47:16 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-12 at 14:34:07 UTC, Frederic Barrat wrote:
> From: Christophe Lombard <clombard@linux.vnet.ibm.com>
> 
> The new Coherent Accelerator Interface Architecture, level 2, for the
> IBM POWER9 brings new content and features:
> - POWER9 Service Layer
> - Registers
> - Radix mode
> - Process element entry
> - Dedicated-Shared Process Programming Model
> - Translation Fault Handling
> - CAPP
> - Memory Context ID
>     If a valid mm_struct is found the memory context id is used for each
>     transaction associated with the process handle. The PSL uses the
>     context ID to find the corresponding process element.
> 
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f24be42aab37c6d07c05126673138e

cheers
