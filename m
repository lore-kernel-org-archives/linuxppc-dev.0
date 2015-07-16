Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BDECE1A08A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 19:54:56 +1000 (AEST)
In-Reply-To: <1436241419-11153-1-git-send-email-anton@samba.org>
To: Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
 paulus@samba.org, mikey@neuling.org, cyril.bur@au1.ibm.com
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Remove mtmsrd(), use existing mtmsr()
Message-Id: <20150716095456.971241402B1@ozlabs.org>
Date: Thu, 16 Jul 2015 19:54:56 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-07-07 at 03:56:59 UTC, Anton Blanchard wrote:
> mtmsr() does the right thing on 32bit and 64bit, so use it everywhere.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1c53973172f84fafa8ad

cheers
