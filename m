Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A7567DDE49
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 00:01:35 +1000 (EST)
In-Reply-To: <20070525013005.GB11789@localhost.localdomain>
References: <4655C7A6.2050606@mvista.com>
	<2ded9f19fbaf49a89ed6e32de87f5828@kernel.crashing.org>
	<1180035543.3360.25.camel@zod.rchland.ibm.com>
	<200705242221.17790.arnd@arndb.de>
	<ab81cfaedb70d6911fcbac9c43f5cf69@kernel.crashing.org>
	<20070525013005.GB11789@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2eabe22a10cfff7e88bae6d59596c5a3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 440 ebony patch seems to have broken 85xx build on powerpc.git
Date: Fri, 25 May 2007 16:01:28 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> No, those options _do_ work on 440, but the -mbooke
>> assembler flag disallows isel (since it is an optional
>> insn).
>
> But not on 440GP, which is what Ebony is.

I meant it is an optional insn in the arch.

-mcpu=440 doesn't enable isel, anyway; only -mcpu=e500
does in any FSF GCC release as far as I can see.


Segher
