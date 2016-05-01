Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qySJf6SSwzDqB3
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 May 2016 23:02:26 +1000 (AEST)
In-Reply-To: <1461936393-10131-2-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [v3,02/70] powerpc/mm: Always use STRICT_MM_TYPECHECKS
Message-Id: <3qySJf4fjvz9t47@ozlabs.org>
Date: Sun,  1 May 2016 23:02:26 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-29-04 at 13:25:25 UTC, Michael Ellerman wrote:
> Testing done by Paul Mackerras has shown that with a modern compiler
> there is no negative effect on code generation from enabling
> STRICT_MM_TYPECHECKS.
> 
> So remove the option, and always use the strict type definitions.
> 
> Acked-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Entire series applied to powerpc next.

https://git.kernel.org/powerpc/c/670eea924198456873f3346bb2

cheers
