Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 85D4ADDFDB
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 22:14:14 +1000 (EST)
In-Reply-To: <20070503235620.GB28599@localhost.localdomain>
References: <20070501051804.GB3881@localhost.localdomain>
	<4639CBD8.6010205@ru.mvista.com>
	<20070503123055.GE26659@localhost.localdomain>
	<4639DDE1.40904@ru.mvista.com>
	<71e4c68de5240a652b561d8cfa2e05f3@kernel.crashing.org>
	<463A1941.3090608@ru.mvista.com> <463A2192.6020308@ru.mvista.com>
	<e21cca984c076474a6e89018a198d93a@kernel.crashing.org>
	<20070503235620.GB28599@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b61c8bd861c9b2596e28c6924116c8b6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: powerpc_flash_init(), wtf!?
Date: Fri, 4 May 2007 14:14:02 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> If the RAM and/or ROM sit on the SoC bus, the "ranges"
>> property in the SoC node should be able to translate
>> their addresses, yes.  You could opt for having the
>> memory controller a separate device node, as a sibling
>> of the "soc" node, if that agrees better with your
>> SoC architecture.  "It all depends".
>
> But if the flash really is on an external bus controlled by a bus
> controller on the SoC, it sounds like it should go under that bus
> bridge.  In which case the SoC would need another range in its ranges
> property.

Yeah, it all depends on the specific SoC device.
I don't know which one we're talking about here
so I can't give any more specific advice.


Segher
