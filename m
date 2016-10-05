Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spfzs506JzDrLC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 13:36:25 +1100 (AEDT)
In-Reply-To: <1475231993-20321-1-git-send-email-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/4] powerpc/configs: Enable VMX crypto
Message-Id: <3spfzs2JdVz9sCZ@ozlabs.org>
Date: Wed,  5 Oct 2016 13:36:25 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-30-09 at 10:39:50 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> We see big improvements with the VMX crypto functions (often 10x or more),
> so enable it as a module.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/43c2394fc15028c6d846633d21ebdd

cheers
