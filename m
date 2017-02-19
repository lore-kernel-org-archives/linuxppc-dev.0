Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vR4QY2NZnzDqCg
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 22:33:41 +1100 (AEDT)
In-Reply-To: <20170215184601.11755.30823.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: jallen@linux.vnet.ibm.com, david@gibson.dropbear.id.au,
 mdroth@linux.vnet.ibm.com, sahilmehta17@gmail.com
Subject: Re: [v7,
 4/4] powerpc/pseries: Implement indexed-count hotplug memory remove
Message-Id: <3vR4QX6Y7Yz9s9Z@ozlabs.org>
Date: Sun, 19 Feb 2017 22:33:40 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-02-15 at 18:46:18 UTC, Nathan Fontenot wrote:
> From: Sahil Mehta <sahilmehta17@gmail.com>
> 
> Indexed-count remove for memory hotplug guarantees that a contiguous block
> of <count> lmbs beginning at a specified <index> will be unassigned (NOT
> that <count> lmbs will be removed). Because of Qemu's per-DIMM memory
> management, the removal of a contiguous block of memory currently
> requires a series of individual calls. Indexed-count remove reduces
> this series into a single call.
> 
> Signed-off-by: Sahil Mehta <sahilmehta17@gmail.com>
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/753843471cbbaeca25a5cab51981ee

cheers
