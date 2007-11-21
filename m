Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B9AADDF3C
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 06:20:16 +1100 (EST)
Message-Id: <0DB17B38-FDCA-4C37-940A-D60723868B26@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20071121172927.GA4413@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 2/3] [POWERPC] Add docs for Freescale RapidIO device tree
	node
Date: Wed, 21 Nov 2007 13:20:05 -0600
References: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>
	<Pine.LNX.4.64.0711202313350.24220@blarg.am.freescale.net>
	<20071121172927.GA4413@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 21, 2007, at 11:29 AM, Scott Wood wrote:

> On Tue, Nov 20, 2007 at 11:13:58PM -0600, Kumar Gala wrote:
>>     Required properties:
>>     - compatible        : compatible list, contains 2 entries,  
>> first is
>> -			 "fsl,sata-CHIP", where CHIP is the processor
>> +			 "fsl,CHIP-sata", where CHIP is the processor
>> 			 (mpc8315, mpc8379, etc.) and the second is
>> -			 "fsl,sata-pq2pro"
>> +			 "fsl,pq2pro-sata"
>>     - interrupts        : <interrupt mapping for SATA IRQ>
>>     - interrupt-parent  : optional, if needed for interrupt mapping
>>     - reg               : <registers mapping>
>> @@ -2531,12 +2531,53 @@ platforms are moved over to use the  
>> flattened-device-tree model.
>>    Example:
>>
>> 	sata@19000 {
>> -		compatible = "fsl,mpc8315-sata", "fsl,sata-pq2pro;
>> +		compatible = "fsl,mpc8315-sata", "fsl,pq2pro-sata;
>
> I think you meant to merge these changes with the previous patch...

Yeah a merge issue, I'll look into it.

- k
