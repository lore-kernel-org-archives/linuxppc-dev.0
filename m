Message-ID: <38DA8B2D.ED7A1919@wanadoo.fr>
Date: Thu, 23 Mar 2000 22:22:53 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: cl.en@gmx.net
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: different h/w addresses on one eth
References: <20000323202943.A807@olis.north.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Claus wrote:

> Mar 23 19:57:53 arma kernel: eth0: DC21041 at 0x0400 (PCI bus 0, device 14), h/w address 00:05:02:26:3a:02,

> Mar 23 20:03:27 arma kernel: eth0: Digital DC21041 Tulip rev 33 at 0x400, 00:A0:40:64:5C:40, IRQ 28.

> got someone of this list a solution for different h/w addresses on one eth card?

You may have noticed that you get the second address from the first by
bitswapping each byte. One of your drivers is reading backwards.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
