Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [87.55.233.238])
	by ozlabs.org (Postfix) with ESMTP id 4752CDDF94
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 04:44:54 +1000 (EST)
Date: Tue, 23 Oct 2007 20:44:48 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Dale Farnsworth <dale@farnsworth.org>
Subject: Re: [PATCH] [POWERPC] Fix fallout from sg_page changes
Message-ID: <20071023184448.GE14671@kernel.dk>
References: <20071023145300.GA18989@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071023145300.GA18989@xyzzy.farnsworth.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 23 2007, Dale Farnsworth wrote:
> 
> Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
> ---
>  include/asm-powerpc/dma-mapping.h |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)

Should already be merged in Linus' current tree.

-- 
Jens Axboe
