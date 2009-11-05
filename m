Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C1029B7BBC
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 02:03:32 +1100 (EST)
Subject: Re: [PATCH] sata_fsl: Split hard and soft reset
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091016164436.GA12897@oksana.dev.rtsoft.ru>
Date: Thu, 5 Nov 2009 09:02:47 -0600
Message-Id: <795A2621-9D6C-4D1F-B07B-24E15C55B03F@kernel.crashing.org>
References: <20091016164436.GA12897@oksana.dev.rtsoft.ru>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide <linux-ide@vger.kernel.org>,
	linux-ppc list <linuxppc-dev@ozlabs.org>,
	Ashish Kalra <Ashish.Kalra@freescale.com>,
	Jiang Yutang <b14898@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 16, 2009, at 11:44 AM, Anton Vorontsov wrote:

> From: Jiang Yutang <b14898@freescale.com>
>
> Split sata_fsl_softreset() into hard and soft resets to make
> error-handling more efficient & device and PMP detection more
> reliable.
>
> Also includes fix for PMP support, driver tested with Sil3726,
> Sil4726 & Exar PMP controllers.
>
> [AV: Also fixes resuming from deep sleep on MPC8315 CPUs]
>
> Signed-off-by: Jiang Yutang <b14898@freescale.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> drivers/ata/sata_fsl.c |   84 ++++++++++++++++++++++++ 
> +-----------------------
> 1 files changed, 44 insertions(+), 40 deletions(-)

Jeff,

any update on this going in for .32?

- k
