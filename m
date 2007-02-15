Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E1439DDEAB
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 11:20:45 +1100 (EST)
In-Reply-To: <45D38624.2010604@freescale.com>
References: <20070213060904.GA6214@localhost.localdomain>	<20070213061026.5837FDDDE9@ozlabs.org>	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>	<1171470754.4003.101.camel@zod.rchland.ibm.com>	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B86F@az33exm25.fsl.freescale.net>	<9df9bf3adf511f4c1a7945e022fdd447@kernel.crashing.org>	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B8EF@az33exm25.fsl.freescale.net>
	<1171489360.20192.184.camel@localhost.localdomain>
	<45D38624.2010604@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <41d950885333d3b8f0ab18077f4a1cef@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Date: Thu, 15 Feb 2007 01:20:39 +0100
To: Scott Wood <scottwood@freescale.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> That's the current FSL practice yes. As I said, I'm not too fan of 
>> it. I
>> prefer a more precise representation of the internal bus layout.
>
> I think it makes sense at least for the FSL SoCs, in that from an
> addressing perspective it is like a bus -- the entire block of devices
> can be relocated by writing to one IMMRBAR register, and the only
> hardcoded address is the offset into that block.

So it makes a lot of sense to have all those devices
below the "soc" node (in fact, it is almost necessary).

However, that doesn't mean you cannot show the devices
on the internal busses they really sit on (if they do);
you just have to put those busses somewhere under the
"soc" node.  Just model the device tree after reality
and you won't have problems ;-)


Segher
