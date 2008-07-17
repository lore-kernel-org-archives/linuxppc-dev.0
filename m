Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D4953DE46E
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 00:04:29 +1000 (EST)
In-Reply-To: <1216274011.7740.293.camel@pasglop>
References: <1216274011.7740.293.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d12dd35837ff36cacd16fcd7df59f782@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: powerpc: Fix OF parsing of 64 bits PCI addresses
Date: Thu, 17 Jul 2008 16:00:45 +0200
To: benh@kernel.crashing.org
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The OF parsing code for PCI addresses isn't always treating properly
> the address space indication 0b11 (ie. 0x3) as meaning 64 bits
> memory space.
>
> This means that it fails to parse addresses for PCI BARs that have
> this encoding set by the firmware, which happens on some SLOF
> versions and breaks offb palette handling on Powerstation.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Looks good.

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher
