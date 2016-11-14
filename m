Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHTzr4744zDrBx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:17:28 +1100 (AEDT)
In-Reply-To: <1475318516-8447-1-git-send-email-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, mahesh@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
 hbathini@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/pseries: Use H_CLEAR_HPT to clear MMU hash table during
 kexec
Message-Id: <3tHTzq6cHlz9t2C@ozlabs.org>
Date: Mon, 14 Nov 2016 23:17:27 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-01-10 at 10:41:56 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> An hcall was recently added that does exactly what we need
> during kexec - it clears the entire MMU hash table, ignoring any
> VRMA mappings.
> 
> Try it and fall back to the old method if we get a failure.
> 
> On a POWER8 box with 5TB of memory, this reduces the time it takes to
> kexec a new kernel from from 4 minutes to 1 minute.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5246adec59458b5d325b8e1462ea9e

cheers
