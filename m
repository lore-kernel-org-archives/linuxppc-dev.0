Message-ID: <A3E34B558F5CD211B4980008C7A4A99003C58293@sparrow.eng.gilbarco.com>
From: "Williams, Kevin M." <kevin.m.williams@marconi.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: release_dev: driver.termios_locked[3] not termios_locked for (04:
	47)
Date: Thu, 10 May 2001 16:54:51 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have ported over code to a 2.4 kernel from a 2.2.13 kernel that modified
m8xx_tty.c, serial.c, and uart.c to work with both the SMC/SCC's and an
external UART at the same time.  When my 2.4 kernel boots and after the NFS
filesystem mounts I get:

release_dev: driver.termios_locked[3] not termios_locked for (04:47)

It happens after execve() is called from main.c to start my 'linuxrc'
script.  This device number is for ttyS7, which is setup as the debug
console port the message is displayed on, so I know the tty is functional,
but something in my setup must be wrong?  I continue to boot and
send/receive characters on this console even after the message.  Anyone have
any ideas on what the cause may be?  I suspect some change in the way the
tty's work between 2.2.13 and 2.4 is causing this.  Any ideas?

Any help or advice is greatly appreciated.

Kevin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
