Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8077B1A105E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 20:38:06 +1000 (AEST)
In-Reply-To: <1435812980-16360-1-git-send-email-anton@samba.org>
To: Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Add plain English description for alignment exception
 oopses
Message-Id: <20150707103806.6F87A1402CC@ozlabs.org>
Date: Tue,  7 Jul 2015 20:38:06 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-02-07 at 04:56:20 UTC, Anton Blanchard wrote:
> If we take an alignment exception which we cannot fix, the oops
> currently prints:
> 
> Unable to handle kernel paging request for unknown fault
> 
> Lets print something more useful:
> 
> Unable to handle kernel paging request for unaligned access at address 0xc0000000f77bba8f
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?h=fixes&id=eab861a7a52208868637f47a92caa926ddadd9c7

cheers
