Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CBD40DE3EE
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 16:25:26 +1000 (EST)
Message-Id: <1E08BE9A-BA08-4679-BDAB-A139559322E9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jin Zhengxiong <Jason.Jin@freescale.com>
In-Reply-To: <CC27DED0F8F39E48A7E75FD768688B7A8C1ED3@zch01exm27.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 2/4 V5] MSI support on 83xx/85xx/86xx board
Date: Tue, 20 May 2008 01:24:04 -0500
References: <1210931447-16234-1-git-send-email-Jason.jin@freescale.com>
	<1210931447-16234-2-git-send-email-Jason.jin@freescale.com>
	<1211162910.7758.2.camel@localhost>
	<CC27DED0F8F39E48A7E75FD768688B7A8C1ED3@zch01exm27.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 19, 2008, at 9:26 PM, Jin Zhengxiong wrote:

>> -----Original Message-----
>> From: Michael Ellerman [mailto:michael@ellerman.id.au]
>> Sent: Monday, May 19, 2008 10:09 AM
>> To: Jin Zhengxiong
>> Cc: galak@kernel.crashing.org; linuxppc-dev@ozlabs.org;
>> segher@kernel.crashing.org
>> Subject: Re: [PATCH 2/4 V5] MSI support on 83xx/85xx/86xx board
>>
>> On Fri, 2008-05-16 at 17:50 +0800, Jason Jin wrote:
>>> This MSI driver can be used on 83xx/85xx/86xx board.
>>> In this driver, virtual interrupt host and chip were setup.
>> There are
>>> 256 MSI interrupts in this host, Every 32 MSI interrupts
>> cascaded to
>>> one IPIC/MPIC interrupt.
>>> The chip was treated as edge sensitive and some necessary functions
>>> were setup for this chip.
>>>
>>> Before using the MSI interrupt, PCI/PCIE device need to ask
>> for a MSI
>>> interrupt in the 256 MSI interrupts. A 256bit bitmap show which MSI
>>> interrupt was used, reserve bit in the bitmap can be used
>> to force the
>>> device use some designate MSI interrupt in the 256 MSI interrupts.
>>> Sometimes this is useful for testing the all the MSI
>> interrupts. The
>>> msi-available-ranges property in the dts file was used for this
>>> purpose.
>>>
>>> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
>>> ---
>>> In the V5 version:
>>> Make the msi-availble-ranges optional, remove the match
>> function from
>>> the driver, change the compatible according the change in dts.
>>
>> Looks good, MSI bits:
>>
>> Acked-by: Michael Ellerman <michael@ellerman.id.au>
>>
>> cheers
>
> Thanks, Michael.
>
> Kumar, Could you please apply the MSI related patches. Thanks

See my comments about the compatible.  Once those changes are made  
I'll apply these patches.

- k
