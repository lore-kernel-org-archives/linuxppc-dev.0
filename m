Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CFFFEDDEDF
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jan 2009 03:48:16 +1100 (EST)
Message-Id: <1F7739C2-930B-49C1-B8FF-679AF1BBAEAE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081230201916.GA20059@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v2 4/4] powerpc/83xx: Add PCI-E support for all MPC83xx
	boards with PCI-E
Date: Wed, 31 Dec 2008 10:48:07 -0600
References: <20081229164040.GD8215@oksana.dev.rtsoft.ru>
	<C96CE59B-05FA-4728-930F-D4430EFB9B99@kernel.crashing.org>
	<20081230201916.GA20059@oksana.dev.rtsoft.ru>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 30, 2008, at 2:19 PM, Anton Vorontsov wrote:

>>>
>>>
>>> +		compatible = "fsl,mpc8315-pcie", "fsl,mpc8314-pcie";
>>> +		reg = <0xe0009000 0x00001000 0xb0000000 0x01000000>;
>>
>> the size on the 0xb0000000 seems wrong
>
> This is how FSL U-Boots configure the cfg window, and I'm trying to
> retain the compatibility. Anyway, now Linux maps only the first 4kB
> of that area, so we don't actually care about this, but dts is still
> correct for older u-boots. Newer U-Boots might want to correct this
> value if they want to use other cfg window setup...

I'd rather not pollute the .dts with this since I don't believe the  
open source u-boot supports PCIe on 83xx.

- k
