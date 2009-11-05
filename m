Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8568FB7B6F
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 00:52:37 +1100 (EST)
Subject: Re: [PATCH 3/6] P2020DS: Fixup sdhc to use PIO mode
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CF6163088BDE8747873ADAA4AF922BF287EDB0@zmy16exm21.fsl.freescale.net>
Date: Thu, 5 Nov 2009 07:52:25 -0600
Message-Id: <56F6ACCC-7FE8-44E6-BF5E-6361997F524F@kernel.crashing.org>
References: <1253696892-15262-1-git-send-email-B22826@freescale.com>
	<1253696892-15262-2-git-send-email-B22826@freescale.com>
	<1253696892-15262-3-git-send-email-B22826@freescale.com>
	<20090923115518.GB6425@oksana.dev.rtsoft.ru>
	<CF6163088BDE8747873ADAA4AF922BF287EDB0@zmy16exm21.fsl.freescale.net>
To: Gao Guanhua-B22826 <B22826@freescale.com>
Cc: linuxppc-dev@ozlabs.org, sdhci-devel@lists.ossman.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 24, 2009, at 3:28 AM, Gao Guanhua-B22826 wrote:

> Thanks, I will add them.
>
>> -----Original Message-----
>> From: Anton Vorontsov [mailto:avorontsov@ru.mvista.com]
>> Sent: Wednesday, September 23, 2009 7:55 PM
>> To: Gao Guanhua-B22826
>> Cc: sdhci-devel@lists.ossman.eu; linuxppc-dev@ozlabs.org
>> Subject: Re: [PATCH 3/6] P2020DS: Fixup sdhc to use PIO mode
>>
>> On Wed, Sep 23, 2009 at 05:08:09PM +0800, Gao Guanhua wrote:
>>> The SDHC can not work on DMA mode because of the hardware
>> bug, so we
>>> set a broken dma flag and use PIO mode. This patch applies
>> to Rev1.0.
>>
>> Signed-off-by line is missing (in all patches).
>

Any plan to update & repost these patches?

- k
