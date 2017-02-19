Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vR4QX0Yq0zDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 22:33:40 +1100 (AEDT)
In-Reply-To: <20170215184536.11755.63813.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: jallen@linux.vnet.ibm.com, david@gibson.dropbear.id.au,
 mdroth@linux.vnet.ibm.com, sahilmehta17@gmail.com
Subject: Re: [v7,
 3/4] powerpc/pseries: Implement indexed-count hotplug memory add
Message-Id: <3vR4QW6hFWz9sCg@ozlabs.org>
Date: Sun, 19 Feb 2017 22:33:39 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-02-15 at 18:45:56 UTC, Nathan Fontenot wrote:
> From: Sahil Mehta <sahilmehta17@gmail.com>
> 
> Indexed-count add for memory hotplug guarantees that a contiguous block
> of <count> lmbs beginning at a specified <drc index> will be assigned,
> any LMBs in this range that are not already assigned will be DLPAR added.
> Because of Qemu's per-DIMM memory management, the addition of a contiguous
> block of memory currently requires a series of individual calls to add
> each LMB in the block. Indexed-count add reduces this series of calls to
> a single call for the entire block.
> 
> Signed-off-by: Sahil Mehta <sahilmehta17@gmail.com>
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/333f7b76865bec24c66710cf352f89

cheers
