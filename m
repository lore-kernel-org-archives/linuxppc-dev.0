Date: Thu, 4 Apr 2002 21:52:09 +0200
From: Albrecht Dre? <albrecht.dress@arcor.de>
To: Linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: SCSI system freeze w/2.4.18
Message-ID: <20020404195209.GG30247@regulus>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[I already posted this to the users list, but apparently nobody had a
solution...]

I upgraded my PowerMac 7300 from 2.4.6-pre3 to (stock) 2.4.18, and since
then I have a nasty scsi problem: Trying to read data from the cd drive
without a cd loaded (e.g. "dd if=/dev/scd0 of=/dev/null bs=1 count=1")
freezes the machine. I usually use this command in a shutdown script to
detect and eventually eject a floppy and a cd. This worked perfectly before,
but hangs without *any* notice in the logs in 2.4.18.

I am almost sure that this is a SCSI problem, as the same script works still
nicely on an iMac (which has a ide cd drive) with 2.4.18.

System details are--
	PowerMac 7300/166, CD attached to internal scsi bus (MESH),
	verbose scsi logging enabled, mesh compiled into the kernel,
	LinuxPPC 2000, upgraded to Halloween release,
	kernel 2.4.18 from kernel.org, plus post-release elf patch,
	built with gcc-2.95.2, glibc 2.1.3

Thanks in advance for any help,

	Albrecht.


--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Albrecht Dreﬂ  -  Johanna-Kirchner-Straﬂe 13  -  D-53123 Bonn (Germany)
        Phone (+49) 228 6199571  -  mailto:albrecht.dress@arcor.de
_________________________________________________________________________

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
