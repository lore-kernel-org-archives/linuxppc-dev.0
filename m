Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYn6b2Bg8zDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 22:27:19 +1000 (AEST)
In-Reply-To: <1465439470-15456-4-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>, Jack Miller <jack@codezen.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, cyrilbur@gmail.com,
 anton@samba.org
Subject: Re: [v7,3/3] powerpc: Load Monitor Register Tests
Message-Id: <3rYn6b0Xbgz9t0N@ozlabs.org>
Date: Tue, 21 Jun 2016 22:27:18 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-09-06 at 02:31:10 UTC, Michael Neuling wrote:
> From: Jack Miller <jack@codezen.org>
> 
> Adds two tests. One is a simple test to ensure that the new registers
> LMRR and LMSER are properly maintained. The other actually uses the
> existing EBB test infrastructure to test that LMRR and LMSER behave as
> documented.
> 
> Signed-off-by: Jack Miller <jack@codezen.org>
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/16c19a2e983346c547501795aa

cheers
