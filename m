Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <4097DAEA.5@ntlworld.com>
Date: Tue, 04 May 2004 19:03:22 +0100
From: Richard Danter <richard.danter@ntlworld.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Simple module, but won't build
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I am trying to build a simple module which will let me write to a bank
of LED's on my board.

When I #include <asm/io.h> I get this error:

/opt/eldk3.0/ppc_82xx/usr/include/asm/io.h: In function `virt_to_bus':
/opt/eldk3.0/ppc_82xx/usr/include/asm/io.h:235: `CONFIG_KERNEL_START'
undeclared (first use in this function)

the error also occurs in several other functions. I also see errors when
I #include <asm/uaccess.h> as follows:

/opt/eldk3.0/ppc_82xx/usr/include/asm/uaccess.h: In function `verify_area':
/opt/eldk3.0/ppc_82xx/usr/include/asm/uaccess.h:37: `CONFIG_TASK_SIZE'
undeclared (first use in this function)

also in several functions.

I know I have used these with no problems with an older kernel and
compiler. Is there something I need to add to make these work??

I am using ELDK 3.0 with the 2.4.24-pre2 kernel on an 8260 target.

Many thanks,
Rich

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
