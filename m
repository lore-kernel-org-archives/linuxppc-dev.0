Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4BAAD2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 14:58:26 +1100 (EST)
Message-ID: <1383710296.4776.119.camel@pasglop>
Subject: Re: [PATCH 5/7] IBM Akebono: Add support to the EHCI platform
 driver for Akebono
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alistair Popple <alistair@popple.id.au>
Date: Wed, 06 Nov 2013 14:58:16 +1100
In-Reply-To: <2440701.siW6M1PPWz@mexican>
References: <Pine.LNX.4.44L0.1311051004080.1360-100000@iolanthe.rowland.org>
 <1383681133.4776.95.camel@pasglop> <2440701.siW6M1PPWz@mexican>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 Alan Stern <stern@rowland.harvard.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-11-06 at 14:50 +1100, Alistair Popple wrote:
> Actually a grep of "usb-ehci" turns up the ehci-ppc-of driver which I somehow 
> missed. This driver works and uses .compatible = "usb-ehci" so I can use that 
> instead if that is preferable?
> 
> However it is basically the same as the ehci-platform driver so I guess at 
> some point the two should be merged...

I think the split predates the grand unification of "of" driver and platform,
so yes they should.

Cheers,
Ben.
