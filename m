Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mvVC1cKlzF27l
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 00:54:59 +1000 (AEST)
In-Reply-To: <20180514082736.3699-1-felix@linux.ibm.com>
To: Philippe Bergheaud <felix@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: fbarrat@linux.ibm.com, clombard@linux.ibm.com,
 Philippe Bergheaud <felix@linux.ibm.com>, benh@au1.ibm.com
Subject: Re: [v4,
 1/2] cxl: Set the PBCQ Tunnel BAR register when enabling capi mode
Message-Id: <40mvVC0w17z9s4V@ozlabs.org>
Date: Fri, 18 May 2018 00:54:59 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-05-14 at 08:27:35 UTC, Philippe Bergheaud wrote:
> Skiboot used to set the default Tunnel BAR register value when capi mode
> was enabled. This approach was ok for the cxl driver, but prevented other
> drivers from choosing different values.
> 
> Skiboot versions > 5.11 will not set the default value any longer. This
> patch modifies the cxl driver to set/reset the Tunnel BAR register when
> entering/exiting the cxl mode, with pnv_pci_set_tunnel_bar().
> 
> That should work with old skiboot (since we are re-writing the value
> already set) and new skiboot.
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.ibm.com>
> Reviewed-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Series applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/401dca8cbd14fc4b32d93499dcd12a

cheers
