Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkQkq5r12zDqrR
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 00:10:11 +1000 (AEST)
In-Reply-To: <1467683001-32280-1-git-send-email-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [v2] powerpc/mm: Add a parameter to disable 1TB segs
Message-Id: <3rkQkq4f2pz9t1F@ozlabs.org>
Date: Wed,  6 Jul 2016 00:10:11 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-07 at 01:43:21 UTC, Oliver O'Halloran wrote:
> This patch adds the kernel command line parameter "no_tb_segs" which
> forces the kernel to use 256MB rather than 1TB segments. Forcing the use
> of 256MB segments makes it considerably easier to test code that depends
> on an SLB miss occurring.
> 
> Suggested-by: Michael Neuling <mikey@neuling.org>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/faf7882962e78a4c8ebb846f45

cheers
