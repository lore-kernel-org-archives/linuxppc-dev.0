Mime-Version: 1.0
Message-Id: <a04320401b78cf51b9c51@[192.168.10.144]>
Date: Wed, 1 Aug 2001 08:52:06 +0900
To: linuxppc-embedded@lists.linuxppc.org
From: Masahide Tomita <tomita@itl.nyc.co.jp>
Subject: Where can I configure the base address?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm struggling to get the kernel (zvmlinux) run on our custom board with
860T, but I think I get it loaded on wrong address.
I want the kernel starts from address 0x00000000, but I can't figure out
which file to set the base address for memory map.

And, I find System.map file in top directory ./linux-2.2.14 , but it seems
like it's a system map for vmlinux.
I also would like to know how to get the system map of zvmlinux (zImage),
if it's possible.

Thanks in advance.

--

Masahide Tomita

tomita@itl.nyc.co.jp

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
