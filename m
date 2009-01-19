Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-5.online-age.net (ext-cn0ut-5.online-age.net
	[63.210.253.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7497CDE079
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 22:39:13 +1100 (EST)
Received: from int-cn0ut-4.online-age.net (int-cn0ut-4.online-age.net
	[3.159.252.73])
	by ext-cn0ut-5.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id n0JBWp82030140
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 06:32:51 -0500
Received: from cinmlip01.e2k.ad.ge.com (int-cn0ut-4.online-age.net
	[3.159.252.73])
	by int-cn0ut-4.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id n0JBWohi007417
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 06:32:51 -0500
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH 0/3] powerpc/86xx: Board support for GE Fanuc SBC310
To: linuxppc-dev@ozlabs.org
Date: Mon, 19 Jan 2009 11:32:41 +0000
Message-ID: <20090119112130.9225.82681.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following series implements basic support for the GE Fanuc SBC310, a
6U single board computer, based on the Freescale MPC8641D.

This series provides:
 - The ability to boot the board with a serial console.
 - Ethernet support.
 - Sata and USB.
 - Support for one of the 2 available watchdog timers.
 - Basic support for the on board GPIO.

Martyn
