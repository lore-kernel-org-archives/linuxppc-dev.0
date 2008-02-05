Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [87.55.233.238])
	by ozlabs.org (Postfix) with ESMTP id AA07CDDDF6
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 19:49:12 +1100 (EST)
Date: Tue, 5 Feb 2008 09:17:06 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] iSeries: fix section mismatch in viocd
Message-ID: <20080205081706.GN15220@kernel.dk>
References: <20080205141731.49a91ed4.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080205141731.49a91ed4.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 05 2008, Stephen Rothwell wrote:
> WARNING: drivers/cdrom/viocd.o(.text+0x504): Section mismatch in reference from the function .viocd_probe() to the function .init.text:.find_capability()
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/cdrom/viocd.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> Jens, can this go in through the powerpc tree?

Certainly

-- 
Jens Axboe
