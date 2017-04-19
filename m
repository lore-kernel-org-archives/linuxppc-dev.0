Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w77H72wpczDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 13:47:15 +1000 (AEST)
In-Reply-To: <1491360291-30299-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [RFC,1/3] powerpc: Allow platforms to force-enable CONFIG_SMP
Message-Id: <3w77H71zNmz9s3w@ozlabs.org>
Date: Wed, 19 Apr 2017 13:47:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-05 at 02:44:49 UTC, Michael Ellerman wrote:
> Of the 64-bit Book3S platforms, only powermac supports booting on an
> actual non-SMP system. The other platforms can be built with SMP
> disabled, but it doesn't make a lot of sense given the CPUs they support
> are all multicore or multithreaded.
> 
> So give platforms the option of forcing SMP=y.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/ebbe9d7d3a2ca0d62f1a2c08c7e7a3

cheers
