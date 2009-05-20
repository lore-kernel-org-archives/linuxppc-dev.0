Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0E007DE159
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 23:31:51 +1000 (EST)
Message-Id: <156C2E1E-8E67-4358-B72E-4BB67D79C2AF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20090513194249.BA7D9832E416@gemini.denx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] [PowerPC] MPC8272ADS: fix device tree for 8 MB flash size
Date: Wed, 20 May 2009 08:29:30 -0500
References: <1242155174-2513-1-git-send-email-wd@denx.de>
	<2a27d3730905130328m27743852w2d68a62ebc32ce31@mail.gmail.com>
	<20090513194249.BA7D9832E416@gemini.denx.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Li Yang <leoli@freescale.com>,
	Wolfgang Denk <wd@denx.de>, LKML List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 13, 2009, at 2:42 PM, Wolfgang Denk wrote:

> Dear Li Yang,
>
> In message <2a27d3730905130328m27743852w2d68a62ebc32ce31@mail.gmail.com 
> > you wrote:
>>
>> Although 8MB seems to be the common size used.  It can be very easy
>> changed as a pluggable module.  It might be better to make the code
>> working for any reasonable flash sizes.
>
> You either have to provide a correct device tree for your board, or
> use a boot loader / boot wrapper that fixes the flash base address and
> size.
>
> At the moment, U-Boot does not  contain  any  code  yet  to  do  that
> (patches  welcome :-), and as far as I understand the cuImage wrapper
> works just the other way  round:  it  adjusts  the  mappings  to  the
> settings  in  the  device tree, which may or may not match the actual
> hardware. This may work, but at least gives  you  a  different  flash
> memory  map  in Linux than what you had before in U-Boot, so it's not
> really nice either.
>
>
> Hm... it seems the majority of MPC8272ADS boards seems to come indeed
> with 8 MB NOR flash, so I wonder if the patch should actually go in?
>
> Best regards,
>
> Wolfgang Denk

Scott, any feedback if our boards have 8M or 32M flash modules?

- k
