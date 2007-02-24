Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4B33ADDEC5
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 22:16:52 +1100 (EST)
In-Reply-To: <1172298620.1902.15.camel@localhost.localdomain>
References: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net>
	<A31D7159-8C25-445D-A21D-85F04C1FDC45@kernel.crashing.org>
	<20070222011811.GA18364@localhost.localdomain>
	<45b623f395654fc4f4920b9553794def@kernel.crashing.org>
	<1172298620.1902.15.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d4c2a8614872f7df7d92b8bb569e08d3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Date: Sat, 24 Feb 2007 12:16:46 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Stuart Yoder <b08248@freescale.com>,
	paulus@samba.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Sure, for every specific case one can envision a more neat
>> and compact device tree ;-P
>
> Still... I do think that even in the general case, providing a way to
> directly encode pairs <parent,specifier> is useful, especially when
> interrupt are wired in all sort of crazy ways as is common in the
> embedded world.

If you leave the "interrupts" property intact it might indeed
be a simple/clean/compatible enough change to be useful.


Segher
