From: John Buswell <johnb@one.net>
Reply-To: johnb@mandrakesoft.com
To: linuxppc-dev@lists.linuxppc.org
Subject: reading and writing nvram variables
Message-ID: <Pine.LNX.3.96.1000222212844.9209E-100000@shell.one.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Date: Tue, 22 Feb 2000 16:32:59 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm working on a small PPC project, and I'm trying to read/write
environment variables from OpenFirmware (on a iMac/iBook).

I have been looking at prom.c from the kernel sources, and wondered if
there was something already written to do that, or anyone with any ideas
on how to achieve it. The application is running before Linux is loaded,
so I cannot use /dev/nvram etc.

Thanks

John I.Buswell
Development Engineer
MandrakeSoft


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
