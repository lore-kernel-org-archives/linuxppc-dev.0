Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKKXx2VTkzDvsD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 23:04:01 +1100 (AEDT)
In-Reply-To: <1464328140-31178-2-git-send-email-rashmicy@gmail.com>
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v3,2/2] powerpc/mm: Dump hash table
Message-Id: <3tKKXx0t2Wz9t25@ozlabs.org>
Date: Thu, 17 Nov 2016 23:04:00 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-27-05 at 05:49:00 UTC, Rashmica Gupta wrote:
> Useful to be able to dump the kernel hash page table to check
> which pages are hashed along with their sizes and other details.
> 
> Add a debugfs file to check the hash page table. If radix is enabled
> (and so there is no hash page table) then this file doesn't exist. To
> use this the PPC_PTDUMP config option must be selected.
> 
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1515ab932156257afd8a5864506dab

cheers
