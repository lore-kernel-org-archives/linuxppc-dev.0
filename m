Return-Path: <w.sang@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 41479B708E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Jun 2009 22:05:50 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id ADA4EDDD1B
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jun 2009 22:05:49 +1000 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V2 0/2] mtd/maps/mtd-ram: Make driver usable for the device
	tree
Date: Fri,  5 Jun 2009 14:05:12 +0200
Message-Id: <1244203514-12516-1-git-send-email-w.sang@pengutronix.de>
Cc: devicetree-discuss@ozlabs.org, albrecht.dress@arcor.de,
	linux-mtd@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

this is the new series to adapt the mtd-ram-driver for use with the device
tree. All comments have been addressed and it has been tested on a
phyCORE-MPC5200B-IO (with latest linus-git).

Albrecht: As you used the patches recently, maybe you want to ack them?

Looking forward to comments, especially on the binding. Thanks!

Regards,

   Wolfram
