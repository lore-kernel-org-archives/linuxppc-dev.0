Message-ID: <20020611133650.87793.qmail@web15003.mail.bjs.yahoo.com>
Date: Tue, 11 Jun 2002 21:36:50 +0800 (CST)
From: =?gb2312?q?Dross=20Zhou?= <zjuzhou@yahoo.com.cn>
Subject: About IDE_DIRECT on PCMCIA port in ppcboot and linux
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all:
	We have get the schematic from Steven.
I have some question about the driver in ppcboot and
linux.

1.Why in ppcboot/include/pcmcia.h , all memory windows
have defined same in all boards.These values can be
changed ( if fit with address encode)?
If we just use PCMCIA as IDE , pcmcia_init() will not
been called()?

2.IDE just need a hw_regs_t(via PCMCIA's port) to
access IDE's register and a IRQ , these are enough?

3.If we use normal harddisk(as same in PC), Can this
driver do them?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
