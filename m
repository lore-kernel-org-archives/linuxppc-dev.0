Message-ID: <3F31161C.6000901@dgt-lab.com.pl>
Date: Wed, 06 Aug 2003 16:52:12 +0200
From: Adam Kaczynski <kaczor@dgt-lab.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC8250 MCC driver
References: <20030805191248.1D9E0C59E4@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I would like to present a very simple driver for MPC8250/8260 MCC
working in transparent and HDLC modes, released under GPL.

It uses one time-slot assigner (128 timeslots) and each individual
channel may be transparent or HDLC. The "read" and "write" functions are
non-blocking and the user should block on "poll". This driver is
prepared to work on our custom-made MPC8250 board but it would be easy
to port it to any evaluation board.

http://www.dgt-lab.com.pl/Serwis/char_dev.tgz

This is rather an example code than a fully polished masterpiece but it
works well and it is being tested in our new product. The sample
programmes are attached to this module.

I would like to thank Omanakuttan for his help and for his precious
documentation:
http://www.ibiblio.org/gferg/ldp/MPC8260-MCC-HOWTO.txt

Adam


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
