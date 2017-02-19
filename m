Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vR4Qc4qhyzDqGp
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 22:33:44 +1100 (AEDT)
In-Reply-To: <20170217020135.6361-1-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, Russell Currey <ruscur@russell.cc>
Subject: Re: [v2] powerpc: Add POWER9 architected mode to cputable
Message-Id: <3vR4Qc46QYz9s9Z@ozlabs.org>
Date: Sun, 19 Feb 2017 22:33:44 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-02-17 at 02:01:35 UTC, Russell Currey wrote:
> PVR value of 0x0F000005 means we are arch v3.00 compliant (i.e. POWER9).
> 
> Acked-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6ae3f8ad2017079292cb49c8959b52

cheers
