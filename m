Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7DD2BDDF3E
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 03:04:16 +1000 (EST)
In-Reply-To: <1181234565.5674.182.camel@rhino>
References: <1181147415.5674.108.camel@rhino>
	<af3aa7bd5ff385f5ad94aa7c1d456a35@kernel.crashing.org>
	<1181234565.5674.182.camel@rhino>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <56b6143f7a188370557f3407c5a356c9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Fix the LPC47M192 SuperIO on the MPC8641 HPCN
Date: Thu, 7 Jun 2007 19:04:10 +0200
To: Wade Farnsworth <wfarnsworth@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +	/* enable superio @ 0x4e and keyboard/mouse address decoding */
>>> +	pci_write_config_byte(dev, 0x63, 0x90);
>>
>> I doubt that comment is accurate.
>
> m1575 legacy interface device register 0x63 is the legacy I/O decoding
> control.
>
> Writing 0x90 enables ports 0x4e and 0x4f for Super I/O configuration 
> and
> ports 0x60 and 0x64 for keyboard/mouse.

Ah I see.  Copy this explanation into your next
version of the patch?  :-)


Segher
