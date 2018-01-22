Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxr31V6RzF0XH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:27 +1100 (AEDT)
In-Reply-To: <20180112023928.10926-1-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/2] powerpc/xive: Move definition of ESB bits
Message-Id: <3zPxr14tpSz9t1t@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:24 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-01-12 at 02:39:27 UTC, Benjamin Herrenschmidt wrote:
> >From xive.h to xive-regs.h since it's a HW register definition
> and it can be used from assembly
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/12c1f339cd49119e39063ae67f02d9

cheers
