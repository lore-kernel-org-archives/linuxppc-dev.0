Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E16DCDDE25
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 10:03:38 +1000 (EST)
In-Reply-To: <18068.5706.700933.551828@cargo.ozlabs.ibm.com>
References: <20070709195743.GA26089@ld0162-tx32.am.freescale.net>
	<200707092225.25287.arnd@arndb.de> <4692A5B8.9010702@freescale.com>
	<8CA741AA-D200-474F-943D-ECE4B3ACD38B@kernel.crashing.org>
	<18068.5706.700933.551828@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <89E626D4-D48D-4062-A996-E2DFFE8248E3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Allow exec on 32-bit from readable, non-exec pages,
	with a warning.
Date: Wed, 11 Jul 2007 02:03:24 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Yeah.  Giving the warning is a good thing though.
>
> No, it isn't; it's just noise, if we're not ever going to do anything
> to prevent the behaviour - and we can't.

The same userland code will not run correctly on PPC64 or BookE
systems.  Is that not a reason to warn?


Segher
