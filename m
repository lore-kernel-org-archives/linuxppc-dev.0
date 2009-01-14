Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [93.163.65.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "A common name", Issuer "A common name" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C5997DE1A0
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 18:51:20 +1100 (EST)
Date: Wed, 14 Jan 2009 08:49:52 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 07/13] powerpc/ps3: printing fixups for l64 to ll64
	conversion: drivers/block
Message-ID: <20090114074951.GY30821@kernel.dk>
References: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
	<20090114170448.7bffcb81.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090114170448.7bffcb81.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 14 2009, Stephen Rothwell wrote:
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/block/ps3disk.c |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)
> 
> Jens, if its OK by you, this could go in via the PowerPC tree.

Of course.

-- 
Jens Axboe
