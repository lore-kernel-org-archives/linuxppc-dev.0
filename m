Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB2D31A04D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 17:47:08 +1000 (AEST)
In-Reply-To: <1443153700-15395-2-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, Aaron Sawdey <sawdey@us.ibm.com>,
 Denis Kirjanov <kda@linux-powerpc.org>, Steve Munroe <sjmunroe@us.ibm.com>,
 linuxppc-dev@ozlabs.org, anton@samba.org
Subject: Re: [v2,1/2] powerpc/selftest: Add gettimeofday() benchmark
Message-Id: <20151002074708.8F48B140311@ozlabs.org>
Date: Fri,  2 Oct 2015 17:47:08 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-25-09 at 04:01:39 UTC, Michael Neuling wrote:
> This adds a benchmark directory to the powerpc selftests and adds a
> gettimeofday() benchmark to it.
> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d17475d906fde8e9fe39fff3

cheers
