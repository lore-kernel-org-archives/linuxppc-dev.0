Message-ID: <75DF04AC5ED4D511A9810090273CB4163F5E3E@rokonet-e.rokonet.co.il>
From: Eli Brin <elib@rokonet.co.il>
To: "'Lokesh Kumar'" <lokesh.kumar@wrx-us.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: scc1 serial
Date: Thu, 21 Aug 2003 15:27:37 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Lokesh,

That's all (TQM860L and FADS860T).  But it really depends on your board.

For example: If you have RS232 voltage converter like MAX232 that needs to
be enabled (see: SMC2 on the FADS860) then you need to do extra work.

Configure SCC1 as a UART in the kernel and look at the boot process.  You
will see the ttySx lines appear and you will know...

Best regards,
Eli Brin



-----Original Message-----
From: Lokesh Kumar [mailto:lokesh.kumar@wrx-us.com]
Sent: Wednesday, August 20, 2003 11:38 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: scc1 serial


Hi Everybody,
I have 855T based board, and have 2.4.18 kernel on it. The console is on
SMC1. I want to configure SCC1 as serial as well. To do that, I took uart.c
file from denx eldk, and the Config.in as well. My question -

is that it, or do I need to change any more files, before I configure SCC1
and UART?

Lokesh Kumar
Wireless Matrix USA Inc.
703-262-4032


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
