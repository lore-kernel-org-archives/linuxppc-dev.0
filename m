Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk8fN3THtzDqBD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 22:35:08 +1000 (AEST)
In-Reply-To: <1458124566-17763-2-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [2/2] powerpc: Make generic_memcpy() private to copy_32.S
Message-Id: <3qk8fN1QNsz9t45@ozlabs.org>
Date: Mon, 11 Apr 2016 22:35:08 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-16-03 at 10:36:06 UTC, Michael Ellerman wrote:
> generic_memcpy() is only called from copy_32.S, so there's no reason for
> it to be global.
> 
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/b4c6afdc3a1ad73542c8e92220

cheers
