Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z4h62Qd6zDrvG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 01:11:18 +1000 (AEST)
In-Reply-To: <4302f36bd615c179c92f2007a0f3a1215ba96c55.1531439662.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/8xx: fix handling of early NULL pointer dereference
Message-Id: <41Z4h573nxz9s7c@ozlabs.org>
Date: Tue, 24 Jul 2018 01:11:17 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-07-13 at 13:10:47 UTC, Christophe Leroy wrote:
> NULL pointers are pointers to user memory space. So user pagetable
> has to be set in order to avoid random behaviour in case of NULL
> pointer dereference, otherwise we may encounter random memory
> access hence Machine Check Exception from TLB Miss handlers.
> 
> Set user pagetable as early as possible in order to properly
> catch early kernel NULL pointer dereference.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8c8c10b90d88bfaad41ea34df17bf6

cheers
