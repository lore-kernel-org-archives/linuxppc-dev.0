Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 798E7B7113
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Nov 2010 04:36:25 +1100 (EST)
Subject: Re: [PATCH v2] fsldma: add support to 36-bit physical address
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1289477789-10651-1-git-send-email-leoli@freescale.com>
Date: Mon, 15 Nov 2010 09:17:18 -0600
Message-Id: <DCEA5DA7-D0DC-498C-831D-4EF212DE6421@kernel.crashing.org>
References: <1289477789-10651-1-git-send-email-leoli@freescale.com>
To: Li Yang <leoli@freescale.com>
Cc: dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 11, 2010, at 6:16 AM, Li Yang wrote:

> Expand the dma_mask of fsldma device to 36-bit, indicating that the
> DMA engine can deal with 36-bit physical address and does not need
> the SWIOTLB to create bounce buffer for it when doing dma_map_*().
> 
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> Add more detailed commit message
> 
> drivers/dma/fsldma.c |    4 +++-
> 1 files changed, 3 insertions(+), 1 deletions(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
