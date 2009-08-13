Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9237CB7D24
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 16:44:20 +1000 (EST)
Subject: Re: [PATCH -v2 0/7] powerpc: use asm-generic/dma-mapping-common.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1249448908-18985-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1249448908-18985-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Content-Type: text/plain
Date: Thu, 13 Aug 2009 15:48:42 +1000
Message-Id: <1250142522.3587.110.camel@pasglop>
Mime-Version: 1.0
Cc: mingo@elte.hu, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	galak@kernel.crashing.orga
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-08-05 at 14:08 +0900, FUJITA Tomonori wrote:

> The above swiotlb patchset was merged in -tip so I think that merging
> this patchset via -tip too is the easiest way to handle this patchset.
> 
> The patchset also is available via a git tree:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tomo/linux-2.6-misc.git powerpc

Hi !

While I generally agree here with the patches, I'm not sure it should be
merged via -tip since it mostly touches arch/powerpc files (and I need
to review it a bit more carefully, hopefully you'll have Ack's hitting
your mailbox later today).

Ben.

> =
>  arch/powerpc/Kconfig                       |    7 +-
>  arch/powerpc/include/asm/device.h          |    7 +-
>  arch/powerpc/include/asm/dma-mapping.h     |  318 +++-------------------------
>  arch/powerpc/include/asm/pci.h             |    4 +-
>  arch/powerpc/include/asm/swiotlb.h         |    8 +-
>  arch/powerpc/kernel/dma-iommu.c            |    2 +-
>  arch/powerpc/kernel/dma-swiotlb.c          |   53 ++---
>  arch/powerpc/kernel/dma.c                  |   13 +-
>  arch/powerpc/kernel/ibmebus.c              |    2 +-
>  arch/powerpc/kernel/pci-common.c           |    6 +-
>  arch/powerpc/kernel/vio.c                  |    2 +-
>  arch/powerpc/platforms/85xx/mpc8536_ds.c   |    3 +-
>  arch/powerpc/platforms/85xx/mpc85xx_ds.c   |    3 +-
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c  |    3 +-
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    3 +-
>  arch/powerpc/platforms/cell/iommu.c        |    2 +-
>  arch/powerpc/platforms/ps3/system-bus.c    |    4 +-
>  include/linux/dma-mapping.h                |    1 +
>  18 files changed, 89 insertions(+), 352 deletions(-)
> 
> 
> 
> 
> 
> 
> 
> 
