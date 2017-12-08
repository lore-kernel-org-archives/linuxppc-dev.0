Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ytX3s0yFdzDrM5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Dec 2017 23:39:37 +1100 (AEDT)
In-Reply-To: <20171206122328.913-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/xmon: Don't print hashed pointers in xmon
Message-Id: <3ytX3r538dz9sNd@ozlabs.org>
Date: Fri,  8 Dec 2017 23:39:36 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-12-06 at 12:23:28 UTC, Michael Ellerman wrote:
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> pointers printed with %p are hashed, ie. you don't see the actual
> pointer value but rather a cryptographic hash of its value.
> 
> In xmon we want to see the actual pointer values, because xmon is a
> debugger, so replace %p with %px which prints the actual pointer
> value.
> 
> We justify doing this in xmon because 1) xmon is a kernel crash
> debugger, it's only accessible via the console 2) xmon doesn't print
> to dmesg, so the pointers it prints are not able to be leaked that
> way.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/d8104182087319fd753d6d8e0afcd9

cheers
