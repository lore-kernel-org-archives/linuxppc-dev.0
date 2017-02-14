Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN27y43q6zDr06
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 23:40:30 +1100 (AEDT)
In-Reply-To: <1486694402-28066-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: Add a prototype for mcount() so it can be versioned
Message-Id: <3vN27y1Q5mz9s87@ozlabs.org>
Date: Tue, 14 Feb 2017 23:40:29 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-02-10 at 02:40:02 UTC, Michael Ellerman wrote:
> Currently we get a warning that _mcount() can't be versioned:
> 
>   WARNING: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.
> 
> Add a prototype to asm-prototypes.h to fix it.
> 
> The prototype is not really correct, mcount() is not a normal function,
> it has a special ABI. But for the purpose of versioning it doesn't
> matter.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/99ad503287daf78e19e64e0e51f1d6

cheers
