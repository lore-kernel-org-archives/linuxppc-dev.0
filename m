Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZswY3PRmzDsYT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 08:07:41 +1000 (AEST)
In-Reply-To: <1473143641-25413-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: powerpc/powernv: Detach from PE on releasing PCI device
Message-Id: <3sZswY223Dz9sD5@ozlabs.org>
Date: Fri, 16 Sep 2016 08:07:41 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-06-09 at 06:34:01 UTC, Gavin Shan wrote:
> The PCI hotplug can be part of EEH error recovery. The @pdn and
> the device's PE number aren't removed and added afterwords. The
> PE number in @pdn should be set to an invalid one. Otherwise, the
> PE's device count is decreased on removing devices while failing
> to be increased on adding devices. It leads to unbalanced PE's
> device count and make normal PCI hotplug path broken.
> 
> Fixes: c5f7700bbd2e ("powerpc/powernv: Dynamically release PE")
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/29bf282dec94f6015a675c0076

cheers
