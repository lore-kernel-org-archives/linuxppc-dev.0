Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EBB49DE006
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 23:02:47 +1000 (EST)
Message-Id: <27CED929-FF61-42D3-A53C-C21B4980BF94@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080523125929.GA8752@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 2/4 V6] MSI support on 83xx/85xx/86xx board
Date: Fri, 23 May 2008 08:02:39 -0500
References: <1211531568-31402-1-git-send-email-Jason.jin@freescale.com>
	<1211531568-31402-2-git-send-email-Jason.jin@freescale.com>
	<20080523125929.GA8752@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Jason Jin <Jason.jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 23, 2008, at 7:59 AM, Anton Vorontsov wrote:

> On Fri, May 23, 2008 at 04:32:46PM +0800, Jason Jin wrote:
>> This MSI driver can be used on 83xx/85xx/86xx board.
>> In this driver, virtual interrupt host and chip were
>> setup. There are 256 MSI interrupts in this host, Every 32
>> MSI interrupts cascaded to one IPIC/MPIC interrupt.
>> The chip was treated as edge sensitive and some necessary
>> functions were setup for this chip.
>>
>> Before using the MSI interrupt, PCI/PCIE device need to
>> ask for a MSI interrupt in the 256 MSI interrupts. A 256bit
>> bitmap show which MSI interrupt was used, reserve bit in
>> the bitmap can be used to force the device use some designate
>> MSI interrupt in the 256 MSI interrupts. Sometimes this is useful
>> for testing the all the MSI interrupts. The msi-available-ranges
>> property in the dts file was used for this purpose.
>>
>> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
>> ---
>
> Hello Jason,
>
> Few comments below.

Jason, I'll apply this version.  I expect some clean up based on Anton  
and Stephen's comments.

- k
