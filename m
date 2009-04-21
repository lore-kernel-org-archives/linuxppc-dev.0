Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 631E9DE2E5
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 01:17:10 +1000 (EST)
Message-Id: <E2205842-8019-4CE4-812B-64ABD76F36F4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Ben Dooks <ben-linux@fluff.org>
In-Reply-To: <49EDC0BE.7040505@elphinstone.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] i2c-cpm: Pass dev ptr to dma_*_coherent rather than NULL
Date: Tue, 21 Apr 2009 10:11:51 -0500
References: <49EDC0BE.7040505@elphinstone.net>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	linux-i2c@vger.kernel.org, Mark Ware <mware@elphinstone.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 21, 2009, at 7:49 AM, Mark Ware wrote:

> Recent DMA changes result in a BUG() when NULL is passed to
> dma_alloc_coherent in place of a device.
>
> Signed-off-by: Mark Ware <mware@elphinstone.net>
> ---
>
> This patch fixes the BUG() during boot that has appeared during the
> 2.6.30 window. It has been tested and appears correct on my 8280 based
> board.
> Sent to both linuxppc-dev and linux-i2c, since I'm not sure where it  
> belongs.
>
>
> drivers/i2c/busses/i2c-cpm.c |   14 ++++++++------
> 1 files changed, 8 insertions(+), 6 deletions(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

Ben, I'm expecting you to pick this up unless you tell me otherwise.

- k
