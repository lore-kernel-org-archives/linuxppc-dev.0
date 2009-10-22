Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 411FCB7BBF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Oct 2009 08:11:43 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-i2c@vger.kernel.org
Subject: i2c/janitoral: drop NO_IRQ from the subsystem
Date: Thu, 22 Oct 2009 23:11:25 +0200
Message-Id: <1256245888-25210-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

after having to deal with NO_IRQ confusion more than once, I decided to start a
bit of janitorial work and remove it from the i2c-subsystem. Detail for better
using 0 as "no irq" can be found here: http://lkml.org/lkml/2005/11/21/221

Regards,

   Wolfram
