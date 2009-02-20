Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CCDEFDE13E
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2009 07:45:13 +1100 (EST)
Message-Id: <6F644D32-0FEF-4D42-9735-4ECF5371009F@kernel.crashing.org>
From: Becky Bruce <beckyb@kernel.crashing.org>
To: Benjamin Krill <ben@codiert.org>
In-Reply-To: <20090219220820.GH12204@codiert.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 2/3] powerpc: setup archdata for {of_}platform via a
	single platform_notify
Date: Fri, 20 Feb 2009 14:44:51 -0600
References: <1235076557-24464-1-git-send-email-galak@kernel.crashing.org>
	<1235076557-24464-2-git-send-email-galak@kernel.crashing.org>
	<20090219220820.GH12204@codiert.org>
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 19, 2009, at 4:08 PM, Benjamin Krill wrote:

> * Kumar Gala | 2009-02-19 14:49:16 [-0600]:
>
>> Since a number of powerpc chips are SoCs we end up having dma-able
>> devices that are registered as platform or of_platform devices.  We  
>> need
>> to hook the archdata to setup proper dma_ops for these devices.
>>
>> In the short term the majority of these devices only need the
>> direct_dma_ops as the platforms don't have any IOMMUs.
>>
>> In the future to enable >4G DMA support on ppc32 we can hook  
>> swiotlb ops.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
> Acked-by: Benjamin Krill <ben@codiert.org>

Tested on ppc 86xx, looks good.

Acked-by: Becky Bruce <beckyb@kernel.crashing.org>

-B
