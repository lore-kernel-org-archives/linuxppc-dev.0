Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0Y0H4KWWzDqCB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 08:40:31 +1000 (AEST)
In-Reply-To: <1462164869-16406-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: selftests/powerpc: Fix subpage_prot test to return !0 on failure
Message-Id: <3r0Y0G6Jrsz9ssM@ozlabs.org>
Date: Thu,  5 May 2016 08:40:30 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-02-05 at 04:54:29 UTC, Michael Ellerman wrote:
> It's helpful for automated testing if the test returns error codes back
> to the calling program.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/3a19e500d8cdb39ef9ce128933

cheers
