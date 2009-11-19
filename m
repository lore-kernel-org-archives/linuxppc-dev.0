Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 108861007D1
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 00:57:31 +1100 (EST)
Subject: Re: [PATCH] sata_fsl: Split hard and soft reset
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <FF648E22-3953-4121-9DCE-862BAC5995B9@kernel.crashing.org>
Date: Thu, 19 Nov 2009 07:57:16 -0600
Message-Id: <81E10EFE-C57C-4678-8FF8-0646EFCFB485@kernel.crashing.org>
References: <20091016164436.GA12897@oksana.dev.rtsoft.ru>
	<795A2621-9D6C-4D1F-B07B-24E15C55B03F@kernel.crashing.org>
	<FF648E22-3953-4121-9DCE-862BAC5995B9@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>,
	linux-ide <linux-ide@vger.kernel.org>,
	Ashish Kalra <Ashish.Kalra@freescale.com>, Jeff Garzik <jeff@garzik.org>,
	Jiang Yutang <b14898@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 19, 2009, at 7:51 AM, Kumar Gala wrote:

>
> On Nov 5, 2009, at 9:02 AM, Kumar Gala wrote:
>
>>
>> On Oct 16, 2009, at 11:44 AM, Anton Vorontsov wrote:
>>
>>> From: Jiang Yutang <b14898@freescale.com>
>>>
>>> Split sata_fsl_softreset() into hard and soft resets to make
>>> error-handling more efficient & device and PMP detection more
>>> reliable.
>>>
>>> Also includes fix for PMP support, driver tested with Sil3726,
>>> Sil4726 & Exar PMP controllers.
>>>
>>> [AV: Also fixes resuming from deep sleep on MPC8315 CPUs]
>>>
>>> Signed-off-by: Jiang Yutang <b14898@freescale.com>
>>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>>> ---
>>> drivers/ata/sata_fsl.c |   84 ++++++++++++++++++++++++ 
>>> +-----------------------
>>> 1 files changed, 44 insertions(+), 40 deletions(-)
>>
>> Jeff,
>>
>> any update on this going in for .32?
>
> Jeff?

slightly ignore me, for some reason I didn't see your reply.

- k
