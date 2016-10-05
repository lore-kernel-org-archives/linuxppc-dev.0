Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spfzv3ByGzDrKS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 13:36:27 +1100 (AEDT)
In-Reply-To: <1470111037-18531-4-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: paulus@samba.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [3/9] powerpc/powernv: Specify proper data type for
 PCI_SLOT_ID_PREFIX
Message-Id: <3spfzv14xKz9sQw@ozlabs.org>
Date: Wed,  5 Oct 2016 13:36:26 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-02-08 at 04:10:31 UTC, Gavin Shan wrote:
> This fixes the warning reported from sparse:
> 
>   gwshan@gwshan:~/sandbox/l$ make C=2 CF=-D__CHECK_ENDIAN__ \
>                              arch/powerpc/platforms/powernv/eeh-powernv.o
>         :
>   arch/powerpc/platforms/powernv/eeh-powernv.c:875:23: \
>   warning: constant 0x8000000000000000 is so big it is unsigned long
> 
> Fixes: ebe225312739 ("powerpc/powernv: Support PCI slot ID")
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/066bcd785aac9c10e5f9b873f9bd2e

cheers
