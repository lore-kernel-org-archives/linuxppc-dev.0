Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 46FB567BA1
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 13:59:27 +1100 (EST)
In-Reply-To: <1166149729.31351.43.camel@localhost.localdomain>
References: <1166006370.90082.476088563252.qpush@cradle>
	<20061213104007.4B8F967DA9@ozlabs.org>
	<20061213122353.7498a25e@pb15>
	<1166052344.11914.233.camel@localhost.localdomain>
	<20061213180921.487b1cea@pb15>
	<1166056373.11914.246.camel@localhost.localdomain>
	<1166057940.6838.25.camel@concordia.ozlabs.ibm.com>
	<1166058148.11914.255.camel@localhost.localdomain>
	<1166058412.6838.30.camel@concordia.ozlabs.ibm.com>
	<C53BBACC-211E-4B01-9153-75634372B835@kernel.crashing.org>
	<1166125466.31351.14.camel@localhost.localdomain>
	<DBBE020D-0BFA-44EC-B1C9-D33F96CC924D@kernel.crashing.org>
	<1166149729.31351.43.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C4505CE5-B961-43F1-803B-C20F43CAF408@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 6/9] MPIC MSI allocator
Date: Fri, 15 Dec 2006 03:58:57 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Olof Johansson <olof@lixom.net>, linux-pci@atrey.karlin.mff.cuni.cz,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> If we are going to be pedantic, it should be msi-available- 
>>> sources :-)
>>
>> But a) it's not really MSI-only, and b) they're not source
>> numbers, but delivery vector numbers (yeah, those are almost
>> the same on U3/U4, but hey).
>
> Actually, they aren't vector numbers, those are what you program in  
> the
> MPIC itself to be emited. Thus they are source numbers according to  
> the
> last time I read the docs :-) Not that it matters anyway :-)

Yeah, my bad.

So how about:

"available-interrupts" denotes the input numbers to an
interrupt controller that the OS can freely assign.  This
naming fits in well with the other interrupt property names,
and the semantics are nicely generic.

"msi-ranges", if present, denotes the ranges of input
interrupt numbers that can be used for MSIs (does this
fit what you need well, Olof?)


Segher
