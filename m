Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ptd82GZGzF0dq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 21:23:08 +1000 (AEST)
In-Reply-To: <20180803060601.724-1-rashmica.g@gmail.com>
To: Rashmica Gupta <rashmica.g@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 mikey@neuling.org, benh@kernel.crashing.org, paulus@samba.org,
 bsingharora@gmail.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Subject: Re: [1/2] powerpc: Allow memory that has been hot-removed to be
 hot-added
Message-Id: <41ptd80r8Qz9sCT@ozlabs.org>
Date: Mon, 13 Aug 2018 21:23:07 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-08-03 at 06:06:00 UTC, Rashmica Gupta wrote:
> This patch allows the memory removed by memtrace to be readded to the
> kernel. So now you don't have to reboot your system to add the memory
> back to the kernel or to have a different amount of memory removed.
> 
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
> Tested-by: Michael Neuling <mikey@neuling.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d3da701d3308ce1fa457f32c6c9e21

cheers
