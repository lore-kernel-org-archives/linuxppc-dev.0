Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYn6f20JzzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 22:27:22 +1000 (AEST)
In-Reply-To: <1466476556-12627-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: powerpc/powernv: Print correct PHB type names
Message-Id: <3rYn6f00Ckz9sdg@ozlabs.org>
Date: Tue, 21 Jun 2016 22:27:21 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-21-06 at 02:35:56 UTC, Gavin Shan wrote:
> We're initializing "IODA1" and "IODA2" PHBs though they are IODA2
> and NPU PHBs as below kernel log indicates.
> 
>    Initializing IODA1 OPAL PHB /pciex@3fffe40700000
>    Initializing IODA2 OPAL PHB /pciex@3fff000400000
> 
> This fixes the PHB names. After it's applied, we get:
> 
>    Initializing IODA2 PHB (/pciex@3fffe40700000)
>    Initializing NPU PHB (/pciex@3fff000400000)
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9497a1c1c5b4de2a359b6d8648

cheers
