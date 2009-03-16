Return-Path: <martyn.welch@gefanuc.com>
Received: from exprod5og110.obsmtp.com (exprod5og110.obsmtp.com [64.18.0.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5EFC6DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 21:30:58 +1100 (EST)
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH 0/2 v2] powerpc/86xx: Board support for GE Fanuc PPC9A 
To: linuxppc-dev@ozlabs.org
Date: Mon, 16 Mar 2009 10:30:43 +0000
Message-ID: <20090316102912.10805.98764.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: wim@iguana.be, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following series implements basic support for the GE Fanuc PPC9A, a
6U single board computer, based on the Freescale MPC8641D.

This series provides:
 - The ability to boot the board with a serial console.
 - Ethernet support.
 - Sata and USB.
 - Support for one of the 2 available watchdog timers.
 - Support for the onboard temperature sensors
 - Support for the onboard RTC

v2: Corrections to DTS as suggested by David Gibson

Martyn
