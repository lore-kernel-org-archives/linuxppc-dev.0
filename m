Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6BC861A033F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 22:27:09 +1100 (AEDT)
In-Reply-To: <1447992934-18905-4-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, paulus@samba.org,
 sam.bobroff@au1.ibm.com
Subject: Re: [v2, 3/3] selftests/powerpc: Add TM signal with invalid stack test
Message-Id: <20151215112709.1A1AF1402ED@ozlabs.org>
Date: Tue, 15 Dec 2015 22:27:08 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-20-11 at 04:15:34 UTC, Michael Neuling wrote:
> Test the kernels signal generation code to ensure it can handle an
> invalid stack pointer when transactional.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Tested-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a26f415bf71640f0141e5e94

cheers
