Message-ID: <3C99A4C5.FE7BC02A@imc-berlin.de>
Date: Thu, 21 Mar 2002 10:15:49 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8xx and O_DIRECT ???
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

has anyone successfully used the O_DIRECT option for file writing (on
MPC8xx IDE)?

I pulled the latest linux version from bitkeeper. When I start the file
benchmark "bonnie" (http://www.garloff.de/kurt/linux/bonnie/) using the
-o_direct option, I'll get:

root@idif1:~# bonnie -d /mnt -s 20 -o_direct
Bonnie 1.3: File '/mnt/Bonnie.95', size: 20971520, volumes: 1
Using O_DIRECT for block based I/O
Writing intelligently...       done:   4127 kB/s  73.8 %CPU
Bonnie: drastic I/O error (/mnt/Bonnie.95.0): Not a directory

During the "Writing intelligently" I can see this file!?

So, is -O_DIRECT actually working on MPC8xx?

Thanks a million,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
