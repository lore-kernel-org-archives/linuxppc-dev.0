Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RH00phQzDqhw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:28:28 +1100 (AEDT)
In-Reply-To: <20180302095612.19493-1-felix@linux.vnet.ibm.com>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>, benh@au1.ibm.com,
 clombard@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com
Subject: Re: [v10,1/2] powerpc/powernv: Enable tunneled operations
Message-Id: <401RGz174Dz9sVh@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:22 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-03-02 at 09:56:11 UTC, Philippe Bergheaud wrote:
> P9 supports PCI tunneled operations (atomics and as_notify). This
> patch adds support for tunneled operations on powernv, with a new
> API, to be called by device drivers:
> 
> pnv_pci_enable_tunnel()
>    Enable tunnel operations, tell driver the 16-bit ASN indication
>    used by kernel.
> 
> pnv_pci_disable_tunnel()
>    Disable tunnel operations.
> 
> pnv_pci_set_tunnel_bar()
>    Tell kernel the Tunnel BAR Response address used by driver.
>    This function uses two new OPAL calls, as the PBCQ Tunnel BAR
>    register is configured by skiboot.
> 
> pnv_pci_get_as_notify_info()
>    Return the ASN info of the thread to be woken up.
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Reviewed-by: Christophe Lombard <clombard@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d6a90bb83b5084829558788ea5b881

cheers
