Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnW3f0XVyzDqZS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 22:36:14 +1100 (AEDT)
In-Reply-To: <20170224005210.1318-2-hamish.martin@alliedtelesis.co.nz>
To: Hamish Martin <hamish.martin@alliedtelesis.co.nz>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
 chris.packham@alliedtelesis.co.nz, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2,1/2] powerpc: Move THREAD_SHIFT config to KConfig
Message-Id: <3vnW3d6gXTz9s88@ozlabs.org>
Date: Tue, 21 Mar 2017 22:36:13 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-02-24 at 00:52:09 UTC, Hamish Martin wrote:
> Shift the logic for defining THREAD_SHIFT logic to Kconfig in order to
> allow override by users.
> 
> Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
> Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/476134070c037820bd909ff6e43e0d

cheers
