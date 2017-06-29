Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyzKY5Xn7zDr4K
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 22:21:21 +1000 (AEST)
In-Reply-To: <1498404886-9587-1-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, anton@samba.org
Subject: Re: powerpc/perf: Fix branch event code for power9
Message-Id: <3wyzKY4K7Cz9s3s@ozlabs.org>
Date: Thu, 29 Jun 2017 22:21:21 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-06-25 at 15:34:46 UTC, Madhavan Srinivasan wrote:
> Correct "branch" event code of Power9 is "r4d05e".
> Replace the current "branch" event code with "r4d05e"
> and add a hack to use "r10012" as event code for
> power9 dd1.
> 
> Fixes: d89f473ff6f8 ("powerpc/perf: Fix PM_BRU_CMPL event code for power9")
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/24bedcb7c811375a962a621613ad15

cheers
