Return-Path: <richard.rojfors@mocean-labs.com>
Received: from av8-2-sn3.vrr.skanova.net (av8-2-sn3.vrr.skanova.net
	[81.228.9.184]) by ozlabs.org (Postfix) with ESMTP id 1DAB9B7B3E
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 23:28:37 +1100 (EST)
Message-ID: <4AFD50F0.6050805@mocean-labs.com>
Date: Fri, 13 Nov 2009 13:28:32 +0100
From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
MIME-Version: 1.0
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH v3 0/4] xilinx_spi: Split into platform and of driver, support
	new IP, platform independence.
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	dbrownell@users.sourceforge.net, John Linn <John.Linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

To follow is a series of patches against the xilinx_spi driver.

The patchset is against 2.6.32-rc6

The patchset addresses several problems in the current driver:
* It's PPC only (OF and uses PPC specific memory operations)
* Only supporting big endian writes
* Supports only 8bit SPI, support for DS570 (also 16 or 32 bit) is added.
* A platform driver is introduced for non OF capable architectures.

These patches were posted as one big patch up to 4 iterations, not splitted into 4.

This version, 3, is updated after review from Grant Likely and John Linn

John Linn has also tested the code on PPC, I have only tested on X86.

--Richard
