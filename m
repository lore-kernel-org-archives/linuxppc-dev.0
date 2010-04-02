Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D3C41B7D0F
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Apr 2010 11:17:16 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-i2c@vger.kernel.org
Date: Fri,  2 Apr 2010 02:16:58 +0200
Message-Id: <1270167421-5205-1-git-send-email-w.sang@pengutronix.de>
Subject: Delete NO_IRQ usage from I2C subsystem
Cc: linuxppc-dev@ozlabs.org, Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a resend of my patch series from October (rebased). Only Grant's acks
have been added. Further explanation in the patches itself. Ben, can you pick
them up or tell Grant to do so?

Kind regards,

   Wolfram
