Return-Path: <martyn.welch@gefanuc.com>
Received: from exprod5og101.obsmtp.com (exprod5og101.obsmtp.com [64.18.0.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0EE2DDDE2A
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 23:28:56 +1100 (EST)
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH v3 0/2] powerpc/86xx: Board support for GE Fanuc PPC9A
To: linuxppc-dev@ozlabs.org
Date: Wed, 18 Mar 2009 12:29:08 +0000
Message-ID: <20090318122501.25609.11105.stgit@ubuntu8041.localdomain>
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

v3: Further DTS corrections as suggested by David Gibson

Note: I have left the original wtd compatible tag in as well, so as to avoid 
having to make more changes to the wdt code for this patch (as this will require
the DTS files for the other boards to also be changed). I have changed the 
reference in the board file WRT the PIC, so the legacy value is not needed here.

Martyn
