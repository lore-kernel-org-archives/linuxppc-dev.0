Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [87.55.233.238])
	by ozlabs.org (Postfix) with ESMTP id 652E8DDF04
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 17:14:49 +1000 (EST)
Date: Tue, 23 Oct 2007 09:13:23 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: powerpc: Fix fallout from sg_page() changes
Message-ID: <20071023071323.GE25962@kernel.dk>
References: <1193076664-13652-1-git-send-email-jens.axboe@oracle.com>
	<1193076664-13652-10-git-send-email-jens.axboe@oracle.com>
	<20071023040948.GA19699@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071023040948.GA19699@lixom.net>
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 22 2007, Olof Johansson wrote:
> Fix fallout from 18dabf473e15850c0dbc8ff13ac1e2806d542c15:
> 
> In file included from include/linux/dma-mapping.h:52,
>                  from drivers/base/dma-mapping.c:10:
> include/asm/dma-mapping.h: In function 'dma_map_sg':
> include/asm/dma-mapping.h:288: error: 'struct scatterlist' has no member named 'page'
> include/asm/dma-mapping.h:288: error: 'struct scatterlist' has no member named 'page'
> include/asm/dma-mapping.h:288: error: 'struct scatterlist' has no member named 'page'
> include/asm/dma-mapping.h:289: error: 'struct scatterlist' has no member named 'page'
> include/asm/dma-mapping.h:290: error: 'struct scatterlist' has no member named 'page'
> include/asm/dma-mapping.h: In function 'dma_sync_sg_for_cpu':
> include/asm/dma-mapping.h:331: error: 'struct scatterlist' has no member named 'page'
> 
> drivers/scsi/ps3rom.c: In function 'fetch_to_dev_buffer':
> drivers/scsi/ps3rom.c:150: error: 'struct scatterlist' has no member named 'page'

Applied.

-- 
Jens Axboe
