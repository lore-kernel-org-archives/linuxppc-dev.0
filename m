Date: Wed, 18 Oct 2000 11:25:48 +0200 (CEST)
From: Xavier Grave <grave@ipno.in2p3.fr>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: initial console
Message-ID: <Pine.LNX.4.21.0010181110280.24224-100000@ipnpcu5>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have the following message at boot :

Freeing unused kernel memory: 220k init 12k pmac 4k chrp 4k openfirmware
Warning: unable to open an initial console.
Kernel panic: No init found.  Try passing init= option to kernel.
Rebooting in 180 seconds..

if I give this argument init=/sbin/init it's the same.

Also hen I try to enable virtual terminual I have the following very early:

TCP: Hash tables configured (established 4096 bind 4096)
Starting kswapd v1.8
pc_keyb: controller jammed (0xFF).
pc_keyb: controller jammed (0xFF).
and so on...

Thanks in advance for anyhelp.

xavier
configuration: CPU 603e + Prep Board

33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
