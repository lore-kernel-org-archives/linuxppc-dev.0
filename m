Message-ID: <002101c3e9d3$39f05990$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Fw: 2.6.0 Kernel
Date: Mon, 2 Feb 2004 16:26:28 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have been using the 2.4.xx kernels successfully.  I recently downloaded
2.6.0 to begin playing with it.  All compiles happily until I get to UART.c.
The compilation fails with many errors, for instance:

uart.c:2920 request for member 'tx_bd_base' in something that is not a
structure or union

I suspect I'm missing something obvious that has changed in the include file
structure, but I haven't done anything beyond 'make menuconfig'

Any ideas?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
