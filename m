Message-ID: <007c01c4320f$6fd477b0$6f01a8c0@xiphos.ca>
From: "Joshua Lamorie" <jpl@xiphos.ca>
To: "Richard Danter" <richard.danter@ntlworld.com>,
	"linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <4097DAEA.5@ntlworld.com>
Subject: Re: Simple module, but won't build
Date: Tue, 4 May 2004 15:38:53 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> /opt/eldk3.0/ppc_82xx/usr/include/asm/io.h:235: `CONFIG_KERNEL_START'

> /opt/eldk3.0/ppc_82xx/usr/include/asm/uaccess.h:37: `CONFIG_TASK_SIZE'

These are defined when you are building your kernel.  Before building any
modules,
you need to configure the kernel.

Assuming you use 'make menuconfig'.

    Under 'Code Maturity Level Options' select 'Prompt for advanced kernel
configuration options'.

Then, under General Setup set

    Set Custom Kernel Base Address
    Set Custom user task size

My assumption is that the defaults (0xc0000000 and 0x80000000) are just
dandy.

Joshua

p.s. This type of question is easy to answer by using lxr.linux.no and
searching for freetext or identifier.  No kernel programming should be
performed without this close at hand.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
