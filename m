Message-ID: <017301bfe268$960eed20$4607a8c0@LocalHost>
From: "Gong Zhuo" <gongzhuo@163.net>
To: "Linux PPC Mailing List" <linuxppc-embedded@lists.linuxppc.org>
Subject: How to debug MMU on powerpc?
Date: Fri, 30 Jun 2000 15:55:40 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi:
  I am using MVME2600 and debug my program through serial port. I must use
MMU for some reasons and the virtual address and physical address is not
consistent. That means virtual address 0 maybe physical address 0xc000. I
have used BAT method. All the mapping is finished in assembly language and I
have make the cross-compile , gdb for powerpc-eabi. But how can I link and
debug my program?
  1. If I link my program with virtual address , the code before the mmu is
opened will be linked with the virtual address but they should run in the
physical address.
  2. The powerpc-eabi-gdb will load my program to the entry-point of virtual
address, but the mmu has not been opened at that time.
  ...


Gong Zhuo


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
