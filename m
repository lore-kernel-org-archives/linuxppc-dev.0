Message-ID: <17B78BDF120BD411B70100500422FC63079F83@IIS000>
From: Patrick Lerda <Lerda@microprocess.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Linux 8xx Crash when I tried complex operation... (Linux 8xx
	reliable?)
Date: Tue, 6 Jun 2000 09:32:40 +0200 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've tried to compile linux 2.2.13 8xx with itself, the compilation start
slowly, and
after some times it crashs randomly after some operation. The NIP is always
the same, it points in the libc-2.2.3.so file, but the content of this
address displayed
after a crash is wrong: *NIP=0, and generate a Floating point emulation, and
linux crash.
The 8xx board I use have only 32MB of memory and no swap. I don't
know if this problem come from a lack of memory, or a complex page recovery
problem.
After turning the 8xx cache the problems goes on... It's not probably
related to libc cache line
changes.

If you can do complex operation like this without problem or if you have the
same problem,
let me know...

Patrick LERDA


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
