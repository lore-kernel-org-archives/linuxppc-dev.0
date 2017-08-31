Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgKz05VlzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:35:51 +1000 (AEST)
In-Reply-To: <1489038132-3523-1-git-send-email-me@tobin.cc>
To: "Tobin C. Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Tobin C. Harding" <me@tobin.cc>, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Subject: Re: powerpc: asm: convert directive .llong to .8byte
Message-Id: <3xjgKy5bPMz9t2M@ozlabs.org>
Date: Thu, 31 Aug 2017 21:35:50 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-03-09 at 05:42:12 UTC, "Tobin C. Harding" wrote:
> .llong is an undocumented PPC specific directive. The generic
> equivalent is .quad, but even better (because it's self describing) is
> .8byte.
> 
> Convert directives .llong -> .8byte
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/eb039161da2ff388cc30d076badd8e

cheers
