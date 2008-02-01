Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8D176DDDDB
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 14:32:56 +1100 (EST)
Message-Id: <DBEEDD21-7CA6-4C2C-A072-3E3D7EB8E663@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Zhang Wei <wei.zhang@freescale.com>
In-Reply-To: <ABF87B0B6A38C0458E319AC973ED68AEBD089C@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 1/2] Add RapidIO node into MPC8641HPCN dts file
Date: Thu, 31 Jan 2008 21:32:18 -0600
References: <12017656032841-git-send-email-wei.zhang@freescale.com>
	<47A1FEB4.1040806@freescale.com>
	<ABF87B0B6A38C0458E319AC973ED68AEBD089C@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 31, 2008, at 9:21 PM, Zhang Wei wrote:

>
>
>> -----Original Message-----
>> From: Loeliger Jon
>>
>> Zhang Wei wrote:
>>> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
>>> ---
>>> arch/powerpc/boot/dts/mpc8641_hpcn.dts |   13 +++++++++++++
>>> 1 files changed, 13 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
>> b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
>>> index 556a9ca..1a0fce5 100644
>>> --- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
>>> +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
>>
>>> @@ -499,4 +500,16 @@
>>> 				  0 00100000>;
>>> 		};
>>> 	};
>>> +
>>> +	rapidio0: rapidio@f80c0000 {
>>> +		#address-cells = <2>;
>>> +		#size-cells = <2>;
>>> +		compatible = "fsl,rapidio-delta";
>>> +		reg = <f80c0000 20000>;
>>> +		ranges = <0 0 c0000000 0 20000000>;
>>> +		interrupt-parent = <&mpic>;
>>> +		/* err_irq bell_outb_irq bell_inb_irq
>>> +			msg1_tx_irq msg1_rx_irq	msg2_tx_irq
>> msg2_rx_irq */
>>> +		interrupts = <30 2 31 2 32 2 35 2 36 2 37 2 38 2>;
>>> +	};
>>> };
>>
>> Have updates to the booting-without-of.txt file for
>> been made or proposed for the RapidIO node definition?
>>
> I remember Kumar has a patch for RapidIO node of booting-without- 
> of.txt, is it?

I do.. I'll post it and update the .dts patch once I sort through all  
the patches.

- k
