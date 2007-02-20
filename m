Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4F0B7DDE2D
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 06:56:10 +1100 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A58C89@az33exm25.fsl.freescale.net>
References: <20070220020837.GF17818@localhost.localdomain>
	<20070220021235.DC02DDDD06@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A58C89@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ee2e907ab59d7aa9b7bf026437419914@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 12/14] Add device tree for Ebony
Date: Tue, 20 Feb 2007 20:56:04 +0100
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Since UIC1 is cascaded off UIC0 in the interrupt tree,
> UIC1 should have an interrupt-parent pointing to UIC0
> so the interrupt tree can be traversed to the root.

Not necessary if UIC0 is the device tree parent of UIC1.
(And in fact it would be "bad style").  But...

> I know this was beaten to death last week, but I would
> still argue that in the device tree UIC0 and UIC1 should
> be siblings.  (In the interrupt tree the cascade relationship
> is described through interrupt-parent).

... that is my opinion as well (as I'm sure you know ;-) ),
and then of course you _do_ need the interrupt-parent property.


Segher
