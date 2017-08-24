Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xd5sQ64hjzDqR9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 11:13:46 +1000 (AEST)
Message-ID: <1503537218.14064.5.camel@russell.cc>
Subject: Re: [PATCH kernel 0/5] powerpc/eeh: Some cleanups
From: Russell Currey <ruscur@russell.cc>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Alistair Popple <alistair@popple.id.au>
Date: Thu, 24 Aug 2017 11:13:38 +1000
In-Reply-To: <20170823101901.33961-1-aik@ozlabs.ru>
References: <20170823101901.33961-1-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-23 at 20:18 +1000, Alexey Kardashevskiy wrote:
> Here are few patches to get rid of some cached pointers across EEH and
> powernv code as I was struggling to figure out about lifetime of
> structures and so on.

Thanks for the patches.  For the whole series:

Acked-by: Russell Currey <ruscur@russell.cc>

> 
> 
> This is based on sha1
> 98b9f8a45499 Linus Torvalds Merge tag 'ext4_for_linus_stable' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
> 
> Please comment. Thanks.
> 
> 
> 
> Alexey Kardashevskiy (5):
>   powerpc/pci: Remove unused parameter from add_one_dev_pci_data()
>   powerpc/eeh: Reduce to one the number of places where edev is
>     allocated
>   powerpc/eeh: Remove unnecessary pointer to phb from eeh_dev
>   powerpc/eeh: Remove unnecessary config_addr from eeh_dev
>   powerpc/eeh: Remove unnecessary node from pci_dn
> 
>  arch/powerpc/include/asm/eeh.h               |  5 +-
>  arch/powerpc/include/asm/pci-bridge.h        |  1 -
>  arch/powerpc/kernel/eeh.c                    | 16 ++---
>  arch/powerpc/kernel/eeh_dev.c                |  2 -
>  arch/powerpc/kernel/eeh_driver.c             |  2 +-
>  arch/powerpc/kernel/eeh_pe.c                 | 90 ++++++++++++++++-----------
> -
>  arch/powerpc/kernel/eeh_sysfs.c              |  3 -
>  arch/powerpc/kernel/pci_dn.c                 | 22 +++----
>  arch/powerpc/platforms/powernv/eeh-powernv.c | 29 +++------
>  9 files changed, 78 insertions(+), 92 deletions(-)
> 
