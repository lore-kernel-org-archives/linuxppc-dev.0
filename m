Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B96BB67C76
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jun 2006 23:52:12 +1000 (EST)
In-Reply-To: <1149890843.12687.66.camel@localhost.localdomain>
References: <1149803821.23938.278.camel@cashmere.sps.mot.com>
	<1149826559.12687.41.camel@localhost.localdomain>
	<E1FojK9-0004AD-DN@jdl.com>
	<1149890843.12687.66.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DCA4FA55-CA67-4367-9ABE-823538EB38FA@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/10 v2] Add the MPC8641 HPCN platform files.
Date: Sat, 10 Jun 2006 15:52:00 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Cascade handling is changing with my genirq port. It will be easy to
>>> adapt though. Same comments howveer, you should have a device- 
>>> tree node
>>> for the 8259 (under an ISA bridge, those shall really be in the
>>> device-tree). In general, on-board bridges should be in the  
>>> device-tree,
>>> only slots or standardly routed child PCI devices need not.
>>
>> Can you send me an example?
>
> I'll try to dig something. Power3 at least has MPIC<->8259 cascade, as
> do some IBM blades when running bare metal kernels.

On the blades, the 8259 isn't cascaded to the MPIC.  And we disable
it completely anyway ;-)


Segher
