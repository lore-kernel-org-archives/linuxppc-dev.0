From: jhfami@teramail.com
Message-ID: <61011.211.215.116.239.1087195658.squirrel@www.teramail.com>
Date: Mon, 14 Jun 2004 15:47:38 +0900 (KST)
Subject: static buffer for device driver?
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=euc-KR
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am wondering why most of device drivers like (uart.c, enet.c) does not
use static buffer ( which defined as array with definite size in source
code) . Those drivers use kmalloc, get_free_page functions to allocate
buffer instead of using static buffer.
Actually I have attempt to use static buffer. But virt_to_phys functions
didn't work properly. returned physical address was out of physical
address range. The address was just (virt. addr - 0xC0000000).

Some one explain those things to me, pleeease. ;)

Thanks in advance.

--
Hojin

jhfami@yahoo.co.kr

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
