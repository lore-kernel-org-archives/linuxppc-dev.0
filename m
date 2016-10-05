Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spfzy6KfBzDrM2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 13:36:30 +1100 (AEDT)
In-Reply-To: <1475366978-18713-1-git-send-email-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, gwshan@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/eeh: Quieten EEH message when no adapters are found
Message-Id: <3spfzy3X0Mz9t0v@ozlabs.org>
Date: Wed,  5 Oct 2016 13:36:29 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-02-10 at 00:09:38 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> No real need for this to be pr_warn(), reduce it to pr_info().
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/91ac730b8b1d7c5e71e7ed2d785a61

cheers
