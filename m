Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zng5N5g4tzF1ky
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 16:39:20 +1100 (AEDT)
In-Reply-To: <f5baf8d9-ece2-d3b8-2793-7701a1184c2a@linux.vnet.ibm.com>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mwb@linux.vnet.ibm.com>
Subject: Re: powerpc: Revert support for ibm,drc-info devtree property
Message-Id: <3zng5N43l3z9sWg@ozlabs.org>
Date: Fri, 23 Feb 2018 16:39:20 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-02-13 at 20:02:53 UTC, Michael Bringmann wrote:
> This reverts commit 02ef6dd8109b581343ebeb1c4c973513682535d6.
> 
> The earlier patch tried to enable support for a new property
> "ibm,drc-info" on powerpc systems.
> 
> Unfortunately, some errors in the associated patch set break things
> in some of the DLPAR operations.  In particular when attempting to
> hot-add a new CPU or set of CPUs, the original patch failed to
> properly calculate the available resources, and aborted the operation.
> In addition, the original set missed several opportunities to compress
> and reuse common code.
> 
> As the associated patch set was meant to provide an optimization of
> storage and performance of a set of device-tree properties for future
> systems with large amounts of resources, reverting just restores
> the previous behavior for existing systems.  It seems unnecessary
> to enable this feature and introduce the consequent problems in the
> field that it will cause at this time, so please revert it for now
> until testing of the corrections are finished properly.
> 
> Signed-off-by: Michael W. Bringmann <mwb@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/c7a3275e0f9e461bb8942132aa6914

cheers
