Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F134FDE032
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 01:10:17 +1000 (EST)
Received: from kiwi.ptxnet.pengutronix.de ([10.1.0.84])
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <sha@pengutronix.de>) id 1Jp35Q-0004WQ-1a
	for linuxppc-dev@ozlabs.org; Thu, 24 Apr 2008 17:10:12 +0200
Received: from sha by kiwi.ptxnet.pengutronix.de with local (Exim 4.69)
	(envelope-from <sha@pengutronix.de>) id 1Jp37l-0002eS-C6
	for linuxppc-dev@ozlabs.org; Thu, 24 Apr 2008 17:12:37 +0200
Date: Thu, 24 Apr 2008 17:12:37 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: mpc5200b custom board upstreamable?
Message-ID: <20080424151237.GI6692@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi all,

I had the intention to push the code for a custom mpc5200b board (freely
available, no internal project) upstream. After cleaning up the code I
realized that actually no board specific code is left and our board is
well handled by the mpc5200_simple_platform machine.

The only issue is that the machine only matches things like
"schindler,cm5200", there's no generic entry. Would it be possible to
add a "generic-mpc52xx" entry to this list?

Another question: are defconfig and dts files for custom boards acceptable
for upstream?

Sascha

-- 
Pengutronix e.K. - Linux Solutions for Science and Industry
-----------------------------------------------------------
Kontakt-Informationen finden Sie im Header dieser Mail oder
auf der Webseite -> http://www.pengutronix.de/impressum/ <-
