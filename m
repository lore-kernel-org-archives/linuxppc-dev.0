From: ALOEFF@de.ibm.com
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <C1256A33.002D977B.00@d12mta11.de.ibm.com>
Date: Thu, 19 Apr 2001 10:17:58 +0200
Subject: Re: Can I use RiscWatch to load ppcboot?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi

i currently use the riscwatch to load ppcboot into ram and then run it
from there
to do so i changed the start of code segment in board/walnut405/config.mk
to a
address in ram eg. 30000.
in include/config_WALNUT405.h i set th flash and monitor base to the same
address (CFG_FLASH_BASE, CFG_MONITOR_BASE)
load ppcboot with 'load file ppcboot',  set iar to the start address, run

hope this helps

p/s: please excuse the message format.

Andreas Loeffler

--
EL HD S/390 SPP (Support Processor Platform Development)
IBM Entwicklungslabor          Phone: +49 (0) 7031 16 5035
Schoenaicher Str. 220          Fax:   +49 (0) 7031 16 4632
71032 Boeblingen               URL:   http://www.ibm.com




byf <byfmail@yeah.net>
04/19/01 03:51 AM
Please respond to byf


        To:     "linuxppc-embedded@lists.linuxppc.org"
<linuxppc-embedded@lists.linuxppc.org>
        cc:
        Subject:        Can I use RiscWatch to load ppcboot?




Hello,

I am working for walnut 405GP, it has a ROM Monitor and RiscWatch.
now I want to use PPCBoot to overwrite ROM Monitor,
Can I use RiscWatch to load PPCBoot to flash or to ram and run it?

or can I use a kernel with mtd support to finish this?
I have no BDI2000.

Thank you!

                                  byf
                             byfmail@yeah.net


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
