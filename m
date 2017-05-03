Return-Path: <jroedel@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHvTw3NcfzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 May 2017 20:27:00 +1000 (AEST)
Date: Wed, 3 May 2017 12:26:54 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH -next] soc/qbman: fix implicit header dependency now
 causing build fails
Message-ID: <20170503102654.GD5077@suse.de>
References: <20170502222112.16720-1-paul.gortmaker@windriver.com>
 <20170503084240.GC5077@suse.de>
 <20170503191524.41e16fa5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170503191524.41e16fa5@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stephen,

On Wed, May 03, 2017 at 07:15:24PM +1000, Stephen Rothwell wrote:
> It looks like there is at least one more:
> 
> drivers/soc/fsl/qbman/qman.c: In function 'qman_init_fq':
> drivers/soc/fsl/qbman/qman.c:1787:4: error: implicit declaration of function 'dma_map_single' [-Werror=implicit-function-declaration]
> drivers/soc/fsl/qbman/qman.c:1788:21: error: 'DMA_TO_DEVICE' undeclared (first use in this function)
> drivers/soc/fsl/qbman/qman.c:1789:4: error: implicit declaration of function 'dma_mapping_error' [-Werror=implicit-function-declaration]
> 
> This is from a powerpc orenet64_smp_defconfig build of today's
> linux-next.

Thanks, I'll fix that up too later today. Please let me know if you find
more of that in your compile-testing.


	Joerg
