Return-Path: <benjamin.heyne@uni-dortmund.de>
Received: from unimail.uni-dortmund.de (mx1.HRZ.Uni-Dortmund.DE
	[129.217.128.51]) by ozlabs.org (Postfix) with ESMTP id E5A9967B22
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Aug 2006 01:23:38 +1000 (EST)
Received: from bob.dt.e-technik.uni-dortmund.de
	(bob.dt.e-technik.Uni-Dortmund.DE [129.217.163.29])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.13.7/8.13.7) with ESMTP id k77FMpbN028171
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 7 Aug 2006 17:22:56 +0200 (CEST)
Date: Mon, 7 Aug 2006 17:22:51 +0200
From: Benjamin Heyne <benjamin.heyne@uni-dortmund.de>
To: linuxppc-embedded@ozlabs.org
Subject: XUPV2P, which kernel 2.6. device drivers are available?
Message-ID: <20060807172251.1d4e81bd@bob.dt.e-technik.uni-dortmund.de>
In-Reply-To: <20060801100220.26176938@bob.dt.e-technik.uni-dortmund.de>
References: <20060801100220.26176938@bob.dt.e-technik.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,
despite having problems with zlib, I'd like to know which
device drivers for the XUPV2P have already been ported
to the 2.6 kernel? - I don't want to do work twice ;-).

For practicing, I just ported the original Xilinx ENET 100MBit
driver (seems to work in FIFO mode, including MII - At least I
can mount and use a NFS root file system)...but that has probably
already been done elsewhere. I saw that work is going on for 
the SystemACE. - So what about VGA, AC97, PS/2, SATA?

Best regards
Benjamin Heyne
