Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mFrm3Pm4zF14s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 23:38:48 +1000 (AEST)
In-Reply-To: <20180509134229.26278-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/3] powerpc/prom: Drop support for old FDT versions
Message-Id: <40mFrl6jRXz9s0y@ozlabs.org>
Date: Wed, 16 May 2018 23:38:47 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-09 at 13:42:27 UTC, Michael Ellerman wrote:
> In commit e6a6928c3ea1 ("of/fdt: Convert FDT functions to use
> libfdt") (Apr 2014), the generic flat device tree code dropped support
> for flat device tree's older than version 0x10 (16).
> 
> We still have code in our CPU scanning to cope with flat device tree
> versions earlier than 2, which can now never trigger, so drop it.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/89c190627257a38d5e4d7cb3e5382f

cheers
