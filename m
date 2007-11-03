Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4B7E0DDE29
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  4 Nov 2007 06:01:13 +1100 (EST)
Message-ID: <472CC569.9050502@scram.de>
Date: Sat, 03 Nov 2007 20:00:57 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: [PATCH0/2] [POWERPC] Two bug fixes for 2.6.24
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
	netdev <netdev@vger.kernel.org>
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

1. [POWERPC] Kill non-existant symbols from ksyms and commproc.h
2. [POWERPC] fs_enet: select PHYLIB as the driver needs it

This series can be pulled from git://git.bocc.de/dbox2.git for-2.6.24

Thanks,
Jochen
