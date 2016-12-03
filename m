Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tW80L6mK6zDw2B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2016 22:28:18 +1100 (AEDT)
In-Reply-To: <0778d754-b261-9d69-d309-a12970ce1cfa@infradead.org>
To: Geoff Levand <geoff@infradead.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Subject: Re: powerpc/ps3: Fix system hang with GCC 5 builds
Message-Id: <3tW80L5Kqkz9t1F@ozlabs.org>
Date: Sat,  3 Dec 2016 22:28:18 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-29 at 18:47:32 UTC, Geoff Levand wrote:
> GCC 5 generates different code for this bootwrapper null check
> that causes the PS3 to hang very early in its bootup.  This
> check is of limited value, so just get rid of it.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6dff5b67054e17c91bd630bcdda17c

cheers
