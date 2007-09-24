Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8575ADDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Sep 2007 03:12:32 +1000 (EST)
Message-ID: <46F7EFFA.9070203@scram.de>
Date: Mon, 24 Sep 2007 19:12:26 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH#2 0/4] Various bug fixes
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Here is a series fixing some bugs for 8xx powerpc CPUs.

1. [POWERPC] Fix copy'n'paste typo in commproc.c
2. [PPC] Fix cpm_dpram_addr returning phys mem instead of virt mem
3. [PPC] Compile fix for 8xx CPM Ehernet driver
4. [POWERPC] Fix cpm_uart driver (updated)

This series can be pulled from git://git.bocc.de/dbox2.git ppc-fixes

Thanks,
Jochen
