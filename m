Message-ID: <398E11CA.A95426B8@phlo.net>
Date: Sun, 06 Aug 2000 21:32:58 -0400
From: Bill Jackson <hispeed@phlo.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: quik/kernel interaction
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


i have tried to upgrade my kernel from 2.2.15 to 2.2.17(test 5 and benh)
or 2.4.0.  I am able to get the kernels to compile, but they won't
boot.  I have modified my quik.conf file and reran quik.  with any of
the new kernels I have made (I also made the existing 2.2.15 kernel), i
get the quik boot screen and select the kernel I wish to boot and the
screen goes to the "copying OF device tree....done", then says
'booting', but then it locks up.  i never get the actual  kernel to
load....at one point, i was getting a returning from prom_init message,
but I no longer get that message.  I also at one point got messages
"Initializing Fake screen" and "Failed to get address", followed by a
"returning from prom_init" message...but the kernel never actually
loads...I have /boot on /dev/sda2 and have tried everything I can think
of to fix this.  I have used multiple kernels as I thought the problem
was kernel related (first occured when I went to 2.4.0, that didn't
work, so I tried 2.2.17, that didn't work, so I got 2.2.17-benh, that
didn't work either).   Since all these kernels are displaying the same
problem, I think I am doing something wrong, but I don't know
what....any assistance/offers/ideas are greatly appreciated...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
