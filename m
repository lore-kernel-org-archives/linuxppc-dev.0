Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C7514DDDF7
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 14:37:15 +1000 (EST)
Subject: Re: Linux 2.6.26-rc5 (G5 SATA broken)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hugh@veritas.com>
In-Reply-To: <Pine.LNX.4.64.0806051255340.28792@blonde.site>
References: <alpine.LFD.1.10.0806042018060.3473@woody.linux-foundation.org>
	<20080605112436.GA4533@aepfle.de>
	<Pine.LNX.4.64.0806051255340.28792@blonde.site>
Content-Type: text/plain
Date: Fri, 06 Jun 2008 14:36:46 +1000
Message-Id: <1212727006.12464.25.camel@pasglop>
Mime-Version: 1.0
Cc: Olaf Hering <olaf@aepfle.de>, Jeff Garzik <jeff@garzik.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I've been bisecting that on Quad G5 (sata_svw): irq 18: nobody cared ...,
> then later endless ata1.00: exception..., blah blah, ata1: EH complete.
> It comes down to:

Thanks for finding that !

/me likes when he wakes up in the morning to find a G5 bug ... and the
fix in the same thread :-)

Cheers,
Ben.
