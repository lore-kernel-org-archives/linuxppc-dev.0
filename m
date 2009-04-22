Return-Path: <ben@trinity.fluff.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
	by ozlabs.org (Postfix) with ESMTP id 237E6DDF8F
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 11:02:45 +1000 (EST)
Date: Wed, 22 Apr 2009 22:56:46 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] i2c-cpm: Pass dev ptr to dma_*_coherent rather than NULL
Message-ID: <20090422215646.GA19997@trinity.fluff.org>
References: <49EDC0BE.7040505@elphinstone.net>
	<E2205842-8019-4CE4-812B-64ABD76F36F4@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E2205842-8019-4CE4-812B-64ABD76F36F4@kernel.crashing.org>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
	Mark Ware <mware@elphinstone.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 21, 2009 at 10:11:51AM -0500, Kumar Gala wrote:
> 
> On Apr 21, 2009, at 7:49 AM, Mark Ware wrote:
> 
> >Recent DMA changes result in a BUG() when NULL is passed to
> >dma_alloc_coherent in place of a device.
> >
> >Signed-off-by: Mark Ware <mware@elphinstone.net>
> >---
> >
> >This patch fixes the BUG() during boot that has appeared during the
> >2.6.30 window. It has been tested and appears correct on my 8280 based
> >board.
> >Sent to both linuxppc-dev and linux-i2c, since I'm not sure where it  
> >belongs.
> >
> >
> >drivers/i2c/busses/i2c-cpm.c |   14 ++++++++------
> >1 files changed, 8 insertions(+), 6 deletions(-)
> 
> Acked-by: Kumar Gala <galak@kernel.crashing.org>
> 
> Ben, I'm expecting you to pick this up unless you tell me otherwise.

Yes.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
