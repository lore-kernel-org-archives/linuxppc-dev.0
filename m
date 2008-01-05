Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 88A24DDE35
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jan 2008 07:56:41 +1100 (EST)
Subject: Re: [PATCH] Miscellaneous for Taco
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <477FCADA.2010706@pikatech.com>
References: <477F13C0.7040006@pikatech.com>
	<1199517865.7291.50.camel@pasglop> <200801051026.26870.sr@denx.de>
	<477FCADA.2010706@pikatech.com>
Content-Type: text/plain
Date: Sun, 06 Jan 2008 07:56:23 +1100
Message-Id: <1199566583.7291.63.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2008-01-05 at 13:22 -0500, Sean MacLennan wrote:
> Ok. I thought of that, but most 440EP boards have PCI set and don't need 
> the special option. I was worried if I put 440EP someone down the road 
> might remove it as "extraneous". We are probably the only 440EP board 
> with no PCI ;)

Well, it's different.... PCI is an option that can be enabled ... or
not by the board. In our case, the HAS_OHCI thing is just a switch to
indicate that an OHCI can exist, it's not actually adding code, so
it can be safely left ON whenever a 440EP processor is there, it has
no bloat and won't conflict with the PCI option.

Ben.
