Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rsjFH6WSKzDqL9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jul 2016 20:28:19 +1000 (AEST)
In-Reply-To: <57740312.9090900@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v2,1/2] powerpc/pseries: Auto-online hotplugged memory
Message-Id: <3rsjFH5mgcz9syB@ozlabs.org>
Date: Sun, 17 Jul 2016 20:28:19 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-29-06 at 17:19:14 UTC, Nathan Fontenot wrote:
> A recent update (commit id 31bc3858ea3) allows for automatically
> onlining memory that is added. This patch sets the config option
> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y for pseries and updates the
> pseries memory hotplug code so that DLPAR added memory can be
> automatically onlined instead of explicitly onlining the memory.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ec999072442ad531cccbecbd6d

cheers
