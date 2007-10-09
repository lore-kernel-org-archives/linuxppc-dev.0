Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7DF14DE04B
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 00:51:42 +1000 (EST)
In-Reply-To: <470B93CC.6090400@freescale.com>
References: <fa686aa40709251546p725e66dcsbc0483cadb3ec3fb@mail.gmail.com>
	<470AA224.7050709@freescale.com>
	<fa686aa40710082100h29c1d2a8hf939ca3306562fac@mail.gmail.com>
	<E83F8EDA-95EF-4116-A214-D008BA70135D@kernel.crashing.org>
	<470B93CC.6090400@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E5596C2A-8304-4158-B580-CFF9F86F814E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Build failure on treeboot-walnut.c
Date: Tue, 9 Oct 2007 09:51:51 -0500
To: Timur Tabi <timur@freescale.com>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 9, 2007, at 9:44 AM, Timur Tabi wrote:

> Kumar Gala wrote:
>
>> What's the actual compile line?  Want to see the flags to  
>> assembler of -Wa to the compiler.
>
> How do I modify the makefiles to spit out that command line?

try

$ make V=1

- k
