Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7EE0DE133
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 05:26:25 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m6FJQF1u024444
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 12:26:16 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m6FJQEjv006835
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 14:26:14 -0500 (CDT)
Subject: DTC: libfdt Install Woes
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 15 Jul 2008 14:26:14 -0500
Message-Id: <1216149974.20700.14.camel@ld0161-tx32>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David,

Somewhat recently, the DTC commit 6a6c972cdf9e
"dtc: Clean up included Makefile fragments"
removed this line

    LIBFDT_INCLUDES = fdt.h libfdt.h

from the libfdt/Makefile.libfdt.  As a result,
the standalone "make install" is onw failing.

We could put that line back, or remove the
top-level Makefile install target that is
trying to use this definition.

I'm not sure which direction you want to head here.

Thanks,
jdl
