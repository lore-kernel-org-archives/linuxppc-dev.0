MIME-Version: 1.0
Subject: Kernel 2.4.x??
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 2 Feb 2001 16:33:43 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E310A90F7@kolkrabbi.flaga.is>
From: Kári Davíðsson <kd@flaga.is>
To: "Linux Embedded ppc (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am testing the Linux 2.4.1pre12 kernel from fsmlabs (3 day old
snaphot).
Everything seem to be working fine. Actually the migration from 2.2.13
to 2.4.x
was much simpler than I antisipated. There are though some strangeness
in the serial port.

I am not shure if I should blame it on the busybox shell, the kernel or
what.

A telnet session works fine. All commands I type get across the wire and
are interpreted correctly.
But when entering commands on the serial port terminal the shell does
not seem to get the full commands,
e.g. if I type "ls -l" it might respond
"l no such command"

I have not seen any reports about strange behaviour of the serialport
anywhere (here, busybox list) so it might just be mis configuration of
the board (although I have not found any).

So any ideas?

K.D.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
