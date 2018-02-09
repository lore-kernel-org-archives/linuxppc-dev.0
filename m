Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zd1Yx1ghvzF18f
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 15:00:37 +1100 (AEDT)
In-Reply-To: <20180208053354.41725-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Rob Herring <robh@kernel.org>, Alistair Popple <alistair@popple.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [kernel] powerpc/pci: Fix broken INTx configuration via OF
Message-Id: <3zd1Yw5kRtz9t3C@ozlabs.org>
Date: Fri,  9 Feb 2018 15:00:36 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-02-08 at 05:33:54 UTC, Alexey Kardashevskiy wrote:
> Commit 59f47eff03a0 ("powerpc/pci: Use of_irq_parse_and_map_pci() helper")
> correctly states that of_irq_parse_and_map_pci() does the same thing as
> of_irq_parse_pci() does as it simply calls
> of_irq_parse_pci() and irq_create_of_mapping().
> 
> However of_irq_parse_and_map_pci() not only returns 0 for success and
> negative value for an error but also a positive virq value from
> irq_create_of_mapping() which the mentioned commit ignores and
> INTx config fails.
> 
> This fixes the of_irq_parse_and_map_pci() return value handling.
> 
> Fixes: 59f47eff03a0 "powerpc/pci: Use of_irq_parse_and_map_pci() helper"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/560c0f978155282e36f33d21b2aeae

cheers
