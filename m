Content-Type: text/plain
MIME-Version: 1.0
Message-ID: <7T989269826170.02006@webmail4.inner-21cn.com>
Date: Mon, 30 Jul 2001 17:38:29 +0800 (CST)
From: "yah" <hay8888@21cn.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: 
Subject: rebuild kernel
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I use powerpc-linux-gcc to rebuild my kernel--linux-2.4.6.tar.gz. When I 'make
zImage', it has following error:

pmac_pci.c:In function 'init_bandit':
pmac_pci.c:252: 'PCI_VENDOR_ID_APPLE_BANDIT' undeclared (firest use in this function)
pmac_pci.c:252:(Each undeclared identifier is reported only once
pmac_pci.c:252:for each function it appears in.)
make[1]:***[pmac_pci.o] Error1
make[1]:Leaving directory '/usr/local/linux/arch/ppc/kernel'
make: ***[_dir_arch/ppc/kernel] Error 2

I use CDK1.2 made in mvista,and rebuild kernel for MCP750 board. Please give me some advices.Thanks.
-------------------------------
抢注商务邮，手机到我手
http://enterprise.21cn.com/game/
华中科技大学项目管理研究生课程班（广州）招生，29日截止！
http://learning.21cn.com:8080/peixun/detail_course.php?id=5502


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
