Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rsjFJ52YPzDqL9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jul 2016 20:28:20 +1000 (AEST)
In-Reply-To: <5767F707.3050707@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [1/2] powerpc/pseries: Move property cloning into its own routine
Message-Id: <3rsjFJ4Lydz9t0G@ozlabs.org>
Date: Sun, 17 Jul 2016 20:28:20 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-20-06 at 14:00:39 UTC, Nathan Fontenot wrote:
> Move property cloning code into its own routine
> 
> Split the pieces of dlpar_clone_drconf_property() that create a copy of
> the property struct into its own routine. This allows for creating
> clones of more than just the ibm,dynamic-memory property used in memory
> hotplug.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c2101c9039fe2a005f7b4138e0

cheers
