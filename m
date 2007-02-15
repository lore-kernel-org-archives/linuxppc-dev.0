Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 39797DDDF4
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 01:40:22 +1100 (EST)
In-Reply-To: <17875.53329.662052.612956@cargo.ozlabs.ibm.com>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
	<1171470754.4003.101.camel@zod.rchland.ibm.com>
	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B86F@az33exm25.fsl.freescale.net>
	<9df9bf3adf511f4c1a7945e022fdd447@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B8EF@az33exm25.fsl.freescale.net>
	<1171489360.20192.184.camel@localhost.localdomain>
	<122a66d49480520cf87cd748bbfc50bb@kernel.crashing.org>
	<17875.49565.444870.924729@cargo.ozlabs.ibm.com>
	<6c90a73251f09d619498c77264a15fef@kernel.crashing.org>
	<17875.53329.662052.612956@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <65b693652fa034ed521e132a6142b3b7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Date: Thu, 15 Feb 2007 15:40:13 +0100
To: Paul Mackerras <paulus@samba.org>
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

>> Still, if you want to be compatible to "real OF" (and you
>> do, otherwise you would have chosen a structure that is
>> more appropriate for this goal),
>
> We don't require an OF device tree;

When booting on real OF you do.

> what we require is something that
> provides a way to express what the kernel needs to know about the
> hierarchy, interconnections and characteristics of the devices in the
> system.

Sure.  You could have chosen a structure that is closer to the
internal Linux structures.

> That it looks strangely familiar to you is just a
> coincidence. :)

Heh suuuuuuuure :-)


Segher
