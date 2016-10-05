Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spfzx2nb8zDrMq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 13:36:29 +1100 (AEDT)
In-Reply-To: <1470293602-11121-1-git-send-email-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, agraf@suse.de
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Align hot loops of memset() and backwards_memcpy()
Message-Id: <3spfzx0pMzz9t0J@ozlabs.org>
Date: Wed,  5 Oct 2016 13:36:28 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-04-08 at 06:53:22 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> Align the hot loops in our assembly implementation of memset()
> and backwards_memcpy().
> 
> backwards_memcpy() is called from tcp_v4_rcv(), so we might
> want to optimise this a little more.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/12ab11a2c09b30c1938c8e82e53908

cheers
