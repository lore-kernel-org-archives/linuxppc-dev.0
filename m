To: linuxppc-embedded@lists.linuxppc.org
Subject: 2 SCC ethernet on MPC860
From: HORIUCHI satoshi <horiuchi@openloop.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20010514195954Y.horiuchi@openloop.co.jp>
Date: Mon, 14 May 2001 19:59:54 +0900 (JST)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am developping linux-2.4.4 SCC ethernet driver
on my custom board using MPC860(not 860T).

The ethernet port is assigned SCC1 and SCC2.
SCC1 is working fine with "8xx_io/enet.c" driver
used by default kernel configuration. And when
running only SCC2(SCC1 is disabled), it also works
fine.

I patched this driver to make 2 SCC work together
for ethernet port, and it looks working on the
face of things.

When I set same MAC address(SCC1 and SCC2 have
same MAC address), it works. However, when I set
different MAC address, SCC2 does not recieve any
packets, no interrupts. SCC1 is working fine.

o transmission is ok.
o recieving broadcast packets.
o work good when set promiscuous mode.
o initialization order of SCC1,SCC2 does not relate to.

I guess SCC2 is using MAC address of SCC1 when
recognizing distination physical address of recived
packets???

Any special registers to be set when 2 SCC ethenet?

Thanks in advance.

---
HORIUCHI Satoshi

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
