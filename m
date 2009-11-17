Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8D6E0B6F29
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 14:42:54 +1100 (EST)
Message-ID: <4B021BB7.3080603@garzik.org>
Date: Mon, 16 Nov 2009 22:42:47 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] sata_fsl: Split hard and soft reset
References: <20091016164436.GA12897@oksana.dev.rtsoft.ru>
	<795A2621-9D6C-4D1F-B07B-24E15C55B03F@kernel.crashing.org>
In-Reply-To: <795A2621-9D6C-4D1F-B07B-24E15C55B03F@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 11/05/2009 10:02 AM, Kumar Gala wrote:
>
> On Oct 16, 2009, at 11:44 AM, Anton Vorontsov wrote:
>
>> From: Jiang Yutang <b14898@freescale.com>
>>
>> Split sata_fsl_softreset() into hard and soft resets to make
>> error-handling more efficient & device and PMP detection more
>> reliable.
>>
>> Also includes fix for PMP support, driver tested with Sil3726,
>> Sil4726 & Exar PMP controllers.
>>
>> [AV: Also fixes resuming from deep sleep on MPC8315 CPUs]
>>
>> Signed-off-by: Jiang Yutang <b14898@freescale.com>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>> drivers/ata/sata_fsl.c | 84
>> +++++++++++++++++++++++++-----------------------
>> 1 files changed, 44 insertions(+), 40 deletions(-)
>
> Jeff,
>
> any update on this going in for .32?

It seems I missed this, and an SNotification patch for sata_fsl as well 
(Bart noticed the latter)...

Will push, probably tomorrow...

	Jeff
