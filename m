Return-Path: <SRS0+74acc133c76ba73f367c+471+infradead.org+hch@pentafluge.srs.infradead.org>
Date: Tue, 7 Dec 2004 15:03:32 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jason McMullan <jason.mcmullan@timesys.com>
Message-ID: <20041207150332.GA16936@infradead.org>
References: <20041207132031.GA23542@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041207132031.GA23542@jmcmullan.timesys>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] include/asm-ppc/dma-mapping.h macro patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +#define dma_cache_inv(_start,_size)		do { (void)(_start); (void)(_size); } while (0)

this looks really horrible.  What about turning these into inlines?
