Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 1CC5F67B98
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 05:46:23 +1000 (EST)
Date: Wed, 6 Sep 2006 14:33:05 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org, anton@samba.org
Subject: [patch 0/5] [v3] powerpc: PA Semi PWRficient patches
Message-ID: <20060906143305.05b54abb@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

The following series of patches introduces basic support for PA Semi's
PA6T core, and the base platform support for PWRficient PA6T-1682M.

It is split up in 5 separate patches:

1. Reduce default cacheline size to 64 bytes
2. Divorce CPU_FTR_CTRL from CPU_FTR_PPCAS_ARCH_V2_BASE
3. Cpu table entry, PVR value
4. Basic arch/powerpc/platforms/pasemi contents
5. MAINTAINER entry


Changes since last submission:

* Fix host bridge ioremap typo (Segher)
* Misc IRQ cleanup (Segher)


-Olof
