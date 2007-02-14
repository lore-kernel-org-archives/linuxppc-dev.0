Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <45afe653a3f963e21e58a063c09b1b22@kernel.crashing.org>
References: <20070213061026.5837FDDDE9@ozlabs.org>
	<e9a2d2be6fe9006c1e2e0b65099a1854@kernel.crashing.org>
	<20070214002210.GE11491@localhost.localdomain>
	<45afe653a3f963e21e58a063c09b1b22@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 08:30:43 +1100
Message-Id: <1171488643.20192.177.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> There cannot *exist* any children of the node.  Unless
> your hardware is really weird.  I guess it is :-)
> 
> In such a case, you just don't put a "reg" property in
> the kid nodes.

No. The #address-cells in the interrupt controller is necessary to
define the size of the unit address part of the unit interrupt specifier
of interrupt children. Re-read your spec :-)

Having it set to 0 provides the necessary definition so that the "right
hand" members of an interrupt map don't need a unit address in their
unit interrupt specifier.

Ben.
