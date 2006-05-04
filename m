Return-Path: <SRS0+8d06cb13a40fdd8325e8+984+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 75A8E67A2E
	for <linuxppc-dev@ozlabs.org>; Fri,  5 May 2006 09:34:36 +1000 (EST)
Received: from nat-pool-stn.redhat.com ([62.200.124.98]
	helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.61 #1 (Red Hat Linux))
	id 1FbnL5-0000lh-Se
	for linuxppc-dev@ozlabs.org; Fri, 05 May 2006 00:34:32 +0100
Subject: Flash map information in device tree.
From: David Woodhouse <dwmw2@infradead.org>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Fri, 05 May 2006 00:34:42 +0100
Message-Id: <1146785683.2885.148.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'd like to get rid of some of the 'map' drivers in drivers/mtd/maps/
and replace them with simple platform devices. On PPC, I'd like to do
that with nodes in the device tree, with appropriate properties:
	- physical address
	- size
	- bankwidth
	- chip probe type (CFI/JEDEC/RAM/ROM/etc)
	- partitioning information

Can we define a format for this so it can be included in the device
trees which we're presumably going to be generating for the embedded
boards which are supported by the arch/powerpc kernel?

If we can get either an updated u-boot or a boot wrapper which work on
the Wind River SBC8265 or SBC8560 boards, I might even be able to test
it myself.

-- 
dwmw2
