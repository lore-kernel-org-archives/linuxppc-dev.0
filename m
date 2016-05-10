Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4CYn4ffLzDqBZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 07:48:45 +1000 (AEST)
In-Reply-To: <20160505204444.GE3264@csclub.uwaterloo.ca>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Len Sorensen <lsorense@csclub.uwaterloo.ca>
Subject: Re: powerpc: Fix sstep compile on powerpcspe
Message-Id: <3r4CYn2j81z9t4h@ozlabs.org>
Date: Wed, 11 May 2016 07:48:45 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-05-05 at 20:44:44 UTC, Lennart Sorensen wrote:
> powerpc: Fix sstep compile on powerpcspe
> 
> Commit be96f63375a14ee8e690856ac77e579c75bd0bae introduced ldarx and stdcx
> into the instructions in sstep.c, which are not accepted by the assembler
> on powerpcspe, but does seem to be accepted by the normal powerpc assembler
> even in 32 bit mode.
> 
> Wrap these two instructions in a __powerpc64__ check like it is everywhere
> else in the file.
> 
> Fixes: be96f63375a1 ("powerpc: Split out instruction analysis part of emulate_step()")
> Signed-off-by: Len Sorensen <lsorense@csclub.uwaterloo.ca>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/03be7e53dee606c189a66a7389

cheers
