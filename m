Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 202A6DDE42
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Oct 2007 20:46:14 +1000 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id EC66E1438F
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Oct 2007 12:13:04 +0200 (CEST)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 29351-04 for <linuxppc-dev@ozlabs.org>;
	Sat,  6 Oct 2007 12:13:04 +0200 (CEST)
Message-ID: <47075FA7.3030108@semihalf.com>
Date: Sat, 06 Oct 2007 12:12:55 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 00/15] [POWERPC] TQM5200, CM5200 and Motion-PRO support
Content-Type: text/plain; charset=ISO-8859-2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

The following series of patches adds arch/powerpc support for three MPC5200 based boards:
TQM5200, CM5200 and Motion-PRO.

Included are also patches with modifications to common 52xx code. New helper
routine mpc52xx_find_and_map_path() is added, and is being used in LED driver
for Motion-PRO. Another patch adds mpc52xx_restart(), mpc52xx_halt()
and mpc52xx_power_off(). This modification has been around for some time now
and relies on Sascha Hauer's patch.

01/15 [POWERPC] TQM5200 DTS
02/15 [POWERPC] TQM5200 defconfig
03/15 [POWERPC] TQM5200 board support
04/15 [POWERPC] cm5200 DTS
05/15 [POWERPC] cm5200 defconfig
06/15 [POWERPC] cm5200 board support
07/15 [POWERPC] Promess motionpro DTS
08/15 [POWERPC] Promess motionpro defconfig
09/15 [POWERPC] Promess motionpro board support
10/15 [POWERPC] Add mpc52xx_find_and_map_path(), refactor utility functions.
11/15 [POWERPC] Motion-PRO: Add LED support.
12/15 [POWERPC] Add mpc52xx_restart(), mpc52xx_halt(), mpc52xx_power_off().
13/15 [POWERPC] Init restart/halt/power_off machine hooks for tqm5200.
14/15 [POWERPC] Init restart/halt/power_off machine hooks for cm5200.
15/15 [POWERPC] Init restart/halt/power_off machine hooks for motionpro.

Comments and review notes are welcome.

Cheers,
Marian Balakowicz
