Message-ID: <20020724220610.37041.qmail@web11503.mail.yahoo.com>
Date: Wed, 24 Jul 2002 15:06:10 -0700 (PDT)
From: Khai Trinh <kqtrinh@yahoo.com>
Subject: driver for 440GP
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi folks,

I am trying to write a driver for the 440GP peripheral
device with physical memory map of 0x1xxxxxxxx (total
of 36 bits) on the PLB address space.

When I get to do:

request_mem_region() and then
ioremap64()

Don't I need a 64 bit request_mem_region() call? Is
there such a kernel call before I call ioremap64()?

Thanks,
--Khai


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
