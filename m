Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5BFE51007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 10:18:51 +1100 (EST)
Message-ID: <4B05D247.8040506@garzik.org>
Date: Thu, 19 Nov 2009 18:18:31 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] sata_fsl: Split hard and soft reset
References: <20091016164436.GA12897@oksana.dev.rtsoft.ru>
In-Reply-To: <20091016164436.GA12897@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-ide@vger.kernel.org, Jiang Yutang <b14898@freescale.com>,
	Ashish Kalra <Ashish.Kalra@freescale.com>,
	linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/16/2009 12:44 PM, Anton Vorontsov wrote:
> From: Jiang Yutang<b14898@freescale.com>
>
> Split sata_fsl_softreset() into hard and soft resets to make
> error-handling more efficient&  device and PMP detection more
> reliable.
>
> Also includes fix for PMP support, driver tested with Sil3726,
> Sil4726&  Exar PMP controllers.
>
> [AV: Also fixes resuming from deep sleep on MPC8315 CPUs]
>
> Signed-off-by: Jiang Yutang<b14898@freescale.com>
> Signed-off-by: Anton Vorontsov<avorontsov@ru.mvista.com>
> ---
>   drivers/ata/sata_fsl.c |   84 +++++++++++++++++++++++++-----------------------
>   1 files changed, 44 insertions(+), 40 deletions(-)

applied #upstream-fixes
