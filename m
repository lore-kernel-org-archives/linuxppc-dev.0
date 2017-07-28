Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJl9R2SxbzDrRR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 20:15:55 +1000 (AEST)
In-Reply-To: <20170727153553.9160-1-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Oliver O'Halloran <oohall@gmail.com>, joserz@linux.vnet.ibm.com,
 sjitindarsingh@gmail.com
Subject: Re: [v2] powerpc/mm: Check for _PAGE_PTE in *_devmap()
Message-Id: <3xJl9R1qqgz9s5L@ozlabs.org>
Date: Fri, 28 Jul 2017 20:15:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-07-27 at 15:35:53 UTC, Oliver O'Halloran wrote:
> The ISA radix translation tree contains two different types of entry,
> directories and leaves. The formats of the two entries are different
> with the directory entries containing no spare bits for use by software.
> As a result we need to ensure that the *_devmap() family of functions
> check fail for everything except leaf (PTE) entries.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> Tested-by: Laurent Vivier <lvivier@redhat.com>
> Tested-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/c9c98bc5cc2ab4e0d5c9ad58286fa7

cheers
