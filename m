Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zd1Yv1y4rzF17Q
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 15:00:35 +1100 (AEDT)
In-Reply-To: <1517920597-14588-1-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/64s: Fix MASKABLE_RELON_EXCEPTION_HV_OOL macro
Message-Id: <3zd1Yt4BGnz9t0m@ozlabs.org>
Date: Fri,  9 Feb 2018 15:00:34 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-02-06 at 12:36:37 UTC, Madhavan Srinivasan wrote:
> Commit f14e953b191f ("powerpc/64s: Add support to take additional parameter in MASKABLE_* macro")
> messed up MASKABLE_RELON_EXCEPTION_HV_OOL macro by adding the wrong
> __SOFTEN__ test which caused guest kernel trash at boot. Patch to fix
> the macro to use SOFTEN_TEST_HV instead of SOFTEN_NOTEST_HV.
> 
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Fix-Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/5c11d1e52d996749897a8616860b18

cheers
