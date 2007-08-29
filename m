Return-Path: <rwoodworth@securics.com>
Received: from securics.com (unknown [128.198.58.14])
	by ozlabs.org (Postfix) with ESMTP id DD650DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 09:35:01 +1000 (EST)
Received: from [192.168.0.36] (unknown [192.168.0.36])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by securics.com (Postfix) with ESMTP id 4C017B8C0B8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Aug 2007 17:35:00 -0600 (MDT)
Subject: Xilinx Virtex boot
From: Robert Woodworth <rwoodworth@securics.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Wed, 29 Aug 2007 17:34:54 -0600
Message-Id: <1188430494.8717.26.camel@PisteOff>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm trying to port Linux to a new Virtex Platform.  The kernel will not
uncompress, I get the following on the console:



loaded at:     00400000 004FB19C
board data at: 004F9120 004F919C
relocated to:  00404054 004040D0
zimage at:     00404E50 004F8409
avail ram:     004FC000 04000000

Linux/PPC load: console=ttyUL root=/dev/xsa2
Uncompressing Linux...
zlib_inflateInit2 returned 00506530
exit



Any ideas what causes this error??
Is something mis-configured on my EDK project?


I have 64MB DDR on the OPB *not* the PLB.
Is that a problem??



Rob.
