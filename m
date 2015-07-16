Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F3D1F1A08A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 19:54:57 +1000 (AEST)
In-Reply-To: <1434944747-6028-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: powerpc/powernv: Include VF PE in PELTV of PF PE
Message-Id: <20150716095457.4A6EC14076D@ozlabs.org>
Date: Thu, 16 Jul 2015 19:54:57 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-22-06 at 03:45:47 UTC, Gavin Shan wrote:
> The PELTV of PF PE should include VF PE, which is missed by current
> code, so that the VF PE is frozen automatically when freezing PF PE.
> The patch fixes the PELTV of PF PE to include VF PE.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/283e2d8a594bc902d0c8

cheers
