Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0Y0C6Dg4zDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 08:40:27 +1000 (AEST)
In-Reply-To: <1462172772-38161-1-git-send-email-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [kernel,v2] powerpc/powernv: Fix debug macro
Message-Id: <3r0Y0C4WnHz9t6C@ozlabs.org>
Date: Thu,  5 May 2016 08:40:27 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-02-05 at 07:06:12 UTC, Alexey Kardashevskiy wrote:
> When cfg_dbg() is enabled (i.e. mapped to printk()), gcc produces
> errors as the __func__ parameter is missing (pnv_pci_cfg_read() has one);
> this adds the missing parameter. Since cfg_dbg() is used not just for
> config space access, this replaces it with well-known pr_devel().
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4caa4422e1de66eda7abf91153

cheers
