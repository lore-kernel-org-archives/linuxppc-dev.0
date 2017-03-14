Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjCc800FGzDqq0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 22:46:00 +1100 (AEDT)
In-Reply-To: <1488930021-20227-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: anton@samba.org, amodra@gmail.com
Subject: Re: powerpc/boot: Fix zImage TOC alignment
Message-Id: <3vjCc71lkBz9s3w@ozlabs.org>
Date: Tue, 14 Mar 2017 22:45:59 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-03-07 at 23:40:21 UTC, Michael Ellerman wrote:
> Recent toolchains force the TOC to be 256 byte aligned. We need to
> enforce this alignment in the zImage linker script, otherwise pointers
> to our TOC variables (__toc_start) could be incorrect. If the actual
> start of the TOC and __toc_start don't have the same value we crash
> early in the zImage wrapper.
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Alan Modra <amodra@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/97ee351b50a49717543533cfb85b4b

cheers
