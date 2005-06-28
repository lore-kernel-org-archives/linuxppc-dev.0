Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1FE9567B5D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Jun 2005 16:35:48 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1119889730.25557.19.camel@cashmere.sps.mot.com>
References: <1119889730.25557.19.camel@cashmere.sps.mot.com>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 16:30:37 +1000
Message-Id: <1119940238.5133.206.camel@gaston>
Mime-Version: 1.0
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] PPC32 mem_pieces interface cleanup
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 2005-06-27 at 11:28 -0500, Jon Loeliger wrote:
> Guys,
> 
> As an initial step towards getting the OF Flat Dev tree
> handled in the PPC32 tree, this patch cleans up some of
> the interface parts of the very early mem_pieces manager
> and adds some PPC64-LMB-like routines as well.
> 
> It has been built and booted on 85xx and pmac boards.

Please make sure you CC linuxppc-dev on such patches or they'll be
missed by me and/or paulus most of the time :)

Ben.
