Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AC0F3DDE25
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 01:25:44 +1000 (EST)
Date: Mon, 16 Apr 2007 10:25:33 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4 v2] powerpc: document max-speed and interface-type
	properties
Message-Id: <20070416102533.0f87396f.kim.phillips@freescale.com>
In-Reply-To: <95a9680c565aa196a4ef78964ef9dee1@kernel.crashing.org>
References: <20070413012542.343eb848.kim.phillips@freescale.com>
	<95a9680c565aa196a4ef78964ef9dee1@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 13 Apr 2007 21:02:25 +0200
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> > Since ucc_geth is being migrated to use the phylib, the existing
> > (undocumented) 'interface' property is being deprecated in favour
> > of unconjoined variations 'max-speed' and 'interface-type'.
> 
> Again, please explain why this information shouldn't
> be in the PHY node instead?
> 

Strictly speaking, it should be neither in the UCC node nor the PHY
node, as it describes the connection between the two, but..

the UCC driver utilizes the data itself; the UCC, unlike other network
controllers, does not provide interface data in its programming model.

the phy drivers are not of_ drivers.  Porting phylib drivers to be of_
drivers would break phylib for non-OF arches, e.g. x86.

Kim
