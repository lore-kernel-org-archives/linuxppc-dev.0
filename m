Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BA880DDE25
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 02:59:13 +1100 (EST)
Message-ID: <4797641F.4000902@scram.de>
Date: Wed, 23 Jan 2008 16:58:23 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCHv2 0/8] [POWERPC] 8xx cleanups
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

this is a series against paulus for-2.6.25 tree to clean up various 8xx related stuff.
The series can be pulled from git://git.bocc.de/dbox2.git cleanup.
Patch 6 has been modified to remove the #ifdefs as suggested by Arndt Bergmann.
Patch 8 is a new one.

[POWERPC] Remove unused m8xx_cpm_hostalloc/free/dump()
[POWERPC] Rename m8xx_pic_init to mpc8xx_pics_init
[POWERPC] Remove unneeded and misspelled prototype m8xx_calibrate_decr
[POWERPC] Remove declaration of m8xx_pic_init.
[POWERPC] Remove sysdev/commproc.h
[POWERPC] Get rid of conditional includes of board specific setup
[POWERPC] Rename commproc to cpm1 and cpm2_common.c to cpm2.c
[POWERPC] Move definition of buffer descriptor to cpm.h

Thanks,
Jochen
