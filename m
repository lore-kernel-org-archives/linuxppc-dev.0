Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D436DB6F01
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 07:28:34 +1100 (EST)
Message-ID: <4B2A946E.4040907@embedded-sol.com>
Date: Thu, 17 Dec 2009 22:28:30 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Problem with mini-PCI-E slot on P2020RDB
References: <4B27FEE3.80001@embedded-sol.com>	<0949C49693EF1A47A54B0F0113CDB4A607674F@zin33exm23.fsl.freescale.net>	<4B28A7C3.6040209@embedded-sol.com>	<0949C49693EF1A47A54B0F0113CDB4A6076776@zin33exm23.fsl.freescale.net>	<4B28CBC4.4010501@embedded-sol.com><0949C49693EF1A47A54B0F0113CDB4A6076791@zin33exm23.fsl.freescale.net>	<4B29DC2B.8090405@embedded-sol.com>	<0949C49693EF1A47A54B0F0113CDB4A60767E8@zin33exm23.fsl.freescale.net>	<4B29F23A.9070001@embedded-sol.com>	<0949C49693EF1A47A54B0F0113CDB4A60767F0@zin33exm23.fsl.freescale.net>
	<EBE3ECA5-AC1B-4E1C-A0DA-89260D0F03F6@kernel.crashing.org>
In-Reply-To: <EBE3ECA5-AC1B-4E1C-A0DA-89260D0F03F6@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Mahajan Vivek-B08308 <B08308@freescale.com>, linuxppc-dev@ozlabs.org,
	Aggrwal Poonam-B10812 <B10812@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Kumar
Kumar Gala wrote:
> On Dec 17, 2009, at 2:59 AM, Mahajan Vivek-B08308 wrote:
>
>   
>>> Thanks a lot. If I understand you correctly, the only way I 
>>> can get ath9k driver to work on this board using legacy 
>>> interrupts is to wait for a hardware fix. Right ?
>>>       
>> Correct
>>     
>
> I'm confused.  What's the issue with IRQ0 on the P2020RDB?  Is it used for another purpose?
>   

There's a problem with IRQ0 with respect to mini-PCI-E slot. I have 
Atheros wireless card plugged
into it. ath9k wireless driver for this card uses legacy PCI-E 
interrupts, and I get "irq 16: nobody cared"
message when driver executes request_irq(). Vivek has come to a 
conclusion that the problem is
related to incorrect IRQ0 routing for mini-PCI-E slot on P2020RDB.

Felix.
