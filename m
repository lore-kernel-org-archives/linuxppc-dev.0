MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: mmap with flash
Date: Wed, 30 Apr 2003 12:58:11 +0200
Message-ID: <742AC4678EF8464697DDDFE3B40F6ECD07E2A6@srv-mailrnd.azisa.co.za>
From: "Flavio Pereira" <Flavio.Pereira@za.flextronics.com>
To: "li" <slowforce@21cn.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>I want to implement mmap with flash device!

You can use the kernel flash module for this. See
/linux/drivers/char/flash.c. Instead of mmaping memory (mem) you can
simply open and then mmap the actual flash _device_.

Regards
Flavio Pereira


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
