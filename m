Message-ID: <3BF8D3C8.9934C177@mandrakesoft.com>
Date: Mon, 19 Nov 2001 04:41:28 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: request for testing
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


If anybody has a 21040 or 21041 "tulip" NIC of some kind, I am looking
for big-endian testers for a new driver,
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/drivers/de2104x.c.bz2

A quick "it works" is useful as well as any extended testing you are
motivated to do :)

If you want to play with media settings or whatever, you will need the
latest ethtool from cvs, at http://sf.net/projects/gkernel/

It requires a very recent 2.4.x kernel, but you can get away with
earlier kernels if you copy the latest include/linux/ethtool.h into your
kernel.

--
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
