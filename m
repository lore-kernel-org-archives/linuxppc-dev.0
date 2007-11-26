Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0694DDEDC
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 07:08:52 +1100 (EST)
Subject: Re: Sequoia EMAC only works if u-boot initializes it?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Steven A. Falco" <sfalco@harris.com>
In-Reply-To: <474B1A11.90806@harris.com>
References: <474AED67.4020006@harris.com> <200711261720.26629.sr@denx.de>
	<474B1A11.90806@harris.com>
Content-Type: text/plain
Date: Tue, 27 Nov 2007 07:08:35 +1100
Message-Id: <1196107715.7195.107.camel@pasglop>
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


On Mon, 2007-11-26 at 14:10 -0500, Steven A. Falco wrote:
> I've attached a copy of my bootlog.  I added in one patch to enable
> rgmii but that didn't fix
> it.(http://ozlabs.org/pipermail/linuxppc-dev/2007-October/043435.html)
> 
> I am curious why the new emac driver is enabled in the DENX tree but
> not in the upstream trees.  Has DENX successfully used this driver on
> the Sequoia board?  Am I trying something that is known not to work?
> 
> I'm interested in helping in whatever way I can.  I need ARCH=powerpc
> to use the current Xenomai patches, and I need both EMACs so I can
> evaluate bonding (for high-availability).

Have you tried adding the various patches I posted along with the
patches Valentine posted ?

I'll re-send a full serie later this week. Let us know if those help or
if something is still broken.

Cheers,
Ben.
