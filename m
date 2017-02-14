Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN27x3LnwzDqyq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 23:40:29 +1100 (AEDT)
In-Reply-To: <20170210011659.5052-1-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Fix confusing help text for DISABLE_MPROFILE_KERNEL
Message-Id: <3vN27x1P4qz9s7w@ozlabs.org>
Date: Tue, 14 Feb 2017 23:40:29 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-02-10 at 01:16:59 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> The final paragraph of the help text is reversed - we want to
> enable this option by default, and disable it if the toolchain
> has a working -mprofile-kernel.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/496e9cb5b2aa2ba303d2bbd08518f9

cheers
