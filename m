Message-ID: <3D86F756.2040000@esd-electronics.com>
Date: Tue, 17 Sep 2002 11:35:18 +0200
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: kgdb with 2.4.20pre7 kernel on 405 target
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am trying to use a cross gdb against a 405 target (CPCI405) using a kgdb kernel
on the target. The kernel is exported from bitkeeper this morning.
The host gdb for 405 is version 5.1.1 from the Denx ELDK.

When I boot my target, it stops and waits for the gdb connection. Then
I start ppc_4xx-gdb on my x86 host with vmlinux as argument.

I enter "target remote /dev/ttyS1" at the gdb prompt and get:

Remote debugging using /dev/ttyS0
0xc000d77c in breakinst ()
(gdb)

I thinks that's fine so far. Then I type "c" and my target keeps on booting. My gdb says:

(gdb) c
Continuing.
Can't send signals to this remote system.  SIGILL not sent.

What does this mean ? From now on I cannot interupt the target.

Is this a problem with kgdb ?

Matthias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
