Message-ID: <001101c1d9a5$012556a0$6649a8c0@LEIYINGDU>
From: "Leiying Du" <ldu@solectek.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: _IO_BASE
Date: Mon, 1 Apr 2002 09:45:25 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 I changed the _IO_BASE from 0x80000000 to 0xF0000000. I also set the
 PBR1 of PCMCIA to 0xF0000000 and the IO space is 0x00~0x3f. When I use  the
inw(x) to read or outw(x,y) to write the IO registers, it always return
"Segmentation fault". I guess my IO port address is not correct.
 Should I set the MMU to make the 0xF0000000 to be the IO_PAGE? Thanks,

 Leiying

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
