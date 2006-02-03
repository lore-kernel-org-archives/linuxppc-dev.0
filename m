Return-Path: <atul.sabharwal@exgate.tek.com>
Received: from igate.tek.com (igate.tek.com [192.65.41.20])
	by ozlabs.org (Postfix) with ESMTP id 84F4F689C0
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Feb 2006 08:28:23 +1100 (EST)
Received: from tektronix.tek.com (tektronix.tek.com [128.181.6.43])
	by igate.tek.com (8.12.10+Sun/8.12.10) with ESMTP id k13LSMtT021240
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Feb 2006 13:28:22 -0800 (PST)
Received: from us-bv-u16.global.tektronix.net (us-bv-u16.bv.tek.com
	[128.181.2.45])
	by tektronix.tek.com (8.12.10+Sun/8.12.10) with SMTP id k13LSMSC018038
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Feb 2006 13:28:22 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Gdb with MPC85xx
Date: Fri, 3 Feb 2006 13:28:56 -0800
Message-ID: <4A062D477D842B4C8FC48EA5AF2D41F201AC3678@us-bv-m23.global.tektronix.net>
From: <atul.sabharwal@exgate.tek.com>
To: <dan@embeddededge.com>, <jcampos@mvista.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks Dan. It helps clarify some debug problems.  I was having similar
problem with BDI2000 to program the AM29F flash part on a 885 reference
board.  Finally gave up.  It's probably not supported or the config file
was
wrong.  My actual board uses different flash, so BDI & the board work
well.

There is a bug in ddd (at least debugging u-boot) when code relocates
from flash to RAM (in_ram routine).  The command add-symbol-file u-boot
<text address> to reload symbols did not work due to some ddd bug (it
could not find bounds of current function).  Switched to manual decode
using BDI
peek/poke and objdump.

--
Atul
