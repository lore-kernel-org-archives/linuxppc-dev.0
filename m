Date: Thu, 10 Oct 2002 17:9:20 +0800
From: "=?GB2312?Q?=B5=CB=D3=C0=C1=FA?=" <dengyonglong@sohu.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: how to use the isa emulator on the motorola mpc823 board
Mime-Version: 1.0
Content-Type: text/plain
Message-Id: <20021010084813.AF6425372B@smtp01.sohu.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,

I am using the motorola mpc823 evaluation board and the linux kernel. I
want to connect with a isa card by the UPMB, that's the kernel's default
setting. I have read the bootloader code ,I found it has done all the
work that needed for using the isa emulator. Now, can I access the isa
address area in the kernel or moduler like this:(port size is 16 bit)

	unsigned short *p	0x06000000;		//BR4 = 0x060018C1
	*p = 0x55;
Do some know about it? Thank's very much for you help!

dengyonglong@sohu.com
2002-10-10

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
