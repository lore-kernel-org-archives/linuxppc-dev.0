Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w253C5MqDzDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 08:49:27 +1000 (AEST)
In-Reply-To: <1491372648-21708-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2] powerpc: Make sparsemem the default on 64-bit Book3S
Message-Id: <3w253C4MrQz9sNK@ozlabs.org>
Date: Tue, 11 Apr 2017 08:49:27 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-05 at 06:10:48 UTC, Michael Ellerman wrote:
> Make sparsemem the default on all 64-bit Book3S platforms. It already is
> for pseries and ps3, and we need to enable it for powernv because on
> POWER9 memory between chips is discontiguous.
> 
> For the other platforms sparsemem should work fine, though it might add
> a small amount of overhead. We can always force FLATMEM in the
> defconfigs if necessary.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/7b3912f4223541c5108565d4bad289

cheers
