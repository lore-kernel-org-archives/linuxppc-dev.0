Return-Path: <benh@kernel.crashing.org>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <558860c3d90100cd18df5f9a66cce3f9@kernel.crashing.org>
References: <20070618185715.321010@gmx.net>
	<20070619054232.GB32039@localhost.localdomain>
	<1182429733.24740.12.camel@localhost.localdomain>
	<558860c3d90100cd18df5f9a66cce3f9@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 22 Jun 2007 09:25:25 +1000
Message-Id: <1182468325.24740.18.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: list <linuxppc-dev@ozlabs.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The "#address-cells" property should be completely absent,
> even; for interrupt matching, that means "treat as 0, no
> unit address used in interrupt mapping, just the interrupt
> number", and for the "normal" purpose (defining the format
> of devices on the bus rooted at / represented by this node)
> it means "there is no such bus" -- this is different from
> #address-cells = 0.

I'd rather have it present and explicitely set to 0, which happens to be
what both Apple and IBM OF implementations also do. Have you verified if
the linux parser behaves properly if it's absent ?

Ben.
