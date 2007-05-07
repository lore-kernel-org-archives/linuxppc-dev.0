Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 38CCEDDEF5
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 02:10:03 +1000 (EST)
In-Reply-To: <17982.41898.515331.184888@cargo.ozlabs.ibm.com>
References: <200703201917.l2KJHO51015104@ld0164-tx32.am.freescale.net>
	<17982.41898.515331.184888@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b413dc2538d85382b0fa0b4b49ffb50f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Support new property called interrupt-parents
Date: Mon, 7 May 2007 14:28:32 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, Stuart Yoder <b08248@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Support new property called interrupt-parents.  This enables the
>> description of devices that have multiple interrupts that are routed 
>> to
>> different interrupt controllers.
>
> I think we can get the same effect by using an interrupt-map property
> in the node, with the node's interrupt-parent pointing to itself.
> That way we can just use the existing interrupt-map parsing code.

Sure, or have a separate interrupt nexus node that
represents just this wiring.

We had a very long thread about this before...


Segher
