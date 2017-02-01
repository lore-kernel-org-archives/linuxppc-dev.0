Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vClL24YWDzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 12:05:30 +1100 (AEDT)
In-Reply-To: <20170130071157.22677-1-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/3] powerpc: Move isa bridge definitions to separate include
Message-Id: <3vClL23VbSz9t17@ozlabs.org>
Date: Wed,  1 Feb 2017 12:05:30 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-01-30 at 07:11:55 UTC, Benjamin Herrenschmidt wrote:
> We'll be adding non-PCI isa bridge support so let's not
> have all the definition in pci-bridge.h
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/38e9d36bc149932964dcd25818c7f7

cheers
