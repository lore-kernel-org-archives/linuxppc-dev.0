Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6C226B6F08
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2009 19:56:26 +1100 (EST)
Message-ID: <4B29F23A.9070001@embedded-sol.com>
Date: Thu, 17 Dec 2009 10:56:26 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Mahajan Vivek-B08308 <B08308@freescale.com>
Subject: Re: Problem with mini-PCI-E slot on P2020RDB
References: <4B27FEE3.80001@embedded-sol.com>	<0949C49693EF1A47A54B0F0113CDB4A607674F@zin33exm23.fsl.freescale.net>	<4B28A7C3.6040209@embedded-sol.com>	<0949C49693EF1A47A54B0F0113CDB4A6076776@zin33exm23.fsl.freescale.net>	<4B28CBC4.4010501@embedded-sol.com><0949C49693EF1A47A54B0F0113CDB4A6076791@zin33exm23.fsl.freescale.net>
	<4B29DC2B.8090405@embedded-sol.com>
	<0949C49693EF1A47A54B0F0113CDB4A60767E8@zin33exm23.fsl.freescale.net>
In-Reply-To: <0949C49693EF1A47A54B0F0113CDB4A60767E8@zin33exm23.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Aggrwal Poonam-B10812 <B10812@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mahajan Vivek-B08308 wrote:
>> From: 
>> linuxppc-dev-bounces+vivek.mahajan=freescale.com@lists.ozlabs.
>> org 
>> [mailto:linuxppc-dev-bounces+vivek.mahajan=freescale.com@lists
>> .ozlabs.org] On Behalf Of Felix Radensky
>> Sent: Thursday, December 17, 2009 12:52 PM
>>     
>>> I just noticed a MSI enable bit in 
>>> drivers/net/wireless/ath/ath9k/reg.h
>>> as under, may be we need to trun this on:-
>>>
>>> reg.h:1013:#define AR_PCIE_MSI                              0x4094
>>> reg.h:1014:#define AR_PCIE_MSI_ENABLE                       
>>>       
>> 0x00000001
>>     
>>>   
>>>       
>> According to ath9k developers adding MSI support to the 
>> driver is not trivial.
>> They've tried once, it didn't work and they gave up. Any 
>> chance I can use mini-PCI-E slot without MSI ?
>>     
>
> So, even after enabling the above bit, there were no MSI 
> interrupts from this card. If we look at some of the GbE 
> or SATA drivers, adding MSI is not that hard. ath9k can 
> be an exception. 
>   
Yes, I've enabled that bit, but didn't get any interrupt.
> I reported this issue to the p2020 board designer; but 
> unfortunately he is out until 1/4/10. It could be a missing 
> pull-up issue at IRQ0 or some thing else, I don't know. 
>
>   

Thanks a lot. If I understand you correctly, the only way I can
get ath9k driver to work on this board using legacy interrupts is
to wait for a hardware fix. Right ?

Felix.
