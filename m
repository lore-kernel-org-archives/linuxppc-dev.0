Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8891FDDE24
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 23:21:40 +1100 (EST)
In-Reply-To: <1168431197.22458.336.camel@localhost.localdomain>
References: <1165806548.7260.0.camel@localhost.localdomain>
	<1168398002.571.3.camel@localhost.localdomain>
	<1168399012.22458.328.camel@localhost.localdomain>
	<1168400086.700.12.camel@localhost.localdomain>
	<1168401489.22458.332.camel@localhost.localdomain>
	<1168419440.1704.16.camel@localhost.localdomain>
	<1168431197.22458.336.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e040592354e531e3e9f40059bfc1e0be@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix irq routing on some PowerMac 32 bits
Date: Wed, 10 Jan 2007 13:22:07 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> While I agree that we should definitely test for NULL and properly fail
> instead of crashing, there is still the question of why do you fail at
> this point. Do you have PCI devices that don't have corresponding 
> device
> nodes ? That is not a problem per-se, I'm just wondering if you have a
> device that is supposed to have a node but it's not matching due to a
> problem with the "reg" property...

Yeah, show us the .dts file if you can, it might have
a problem, or at least it does something the kernel
doesn't expect.


Segher
