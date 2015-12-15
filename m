Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE5801A033D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 22:27:07 +1100 (AEDT)
In-Reply-To: <1447992934-18905-3-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, paulus@samba.org,
 sam.bobroff@au1.ibm.com
Subject: Re: [v2,2/3] selftests/powerpc: Add TM signal return test
Message-Id: <20151215112707.79B751402DE@ozlabs.org>
Date: Tue, 15 Dec 2015 22:27:07 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-20-11 at 04:15:33 UTC, Michael Neuling wrote:
> Test the kernel's signal return code to ensure that it doesn't crash
> when both the transactional and suspend MSR bits are set in the signal
> context.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Tested-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/25007a69e852389985ee9823

cheers
