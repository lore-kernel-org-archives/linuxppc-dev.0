Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tW80D53vjzDw1s
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2016 22:28:12 +1100 (AEDT)
In-Reply-To: <1479471342-24195-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/2] powerpc/prom: Define structs for client architecture vectors
Message-Id: <3tW80D3NKxz9t1B@ozlabs.org>
Date: Sat,  3 Dec 2016 22:28:12 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-11-18 at 12:15:41 UTC, Michael Ellerman wrote:
> The "client architecture vectors" are a series of structures we pass to
> firmware to define various things, such as what processors we support
> and many other options.
> 
> Each structure is entirely different so we have to define a different
> struct for each one, but that's OK.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/d03d1d65b5570ab6fba462a09c2b32

cheers
