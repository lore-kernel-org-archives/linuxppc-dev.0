Message-ID: <2702075D4DE2B043BF5EB82E9CFAD45B0CAD26@mail1.mediatrix.com>
From: Sylvain Latulippe <slatulippe@mediatrix.com>
To: "'Michael Thompson'" <mickey@berkeley.innomedia.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Are 8260 and 8250 CPM interface compatible?
Date: Fri, 27 Sep 2002 08:29:17 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> How much of each of the drivers in arch/ppc/8260_io/ can be reused
> for the 8250?  Is the 8250 CPM interface backward compatible
> with the 8260 CPM interface? Or will everything have to be written
> from the ground up?
>

We have tested ethernet (fcc_enet.c), serial port (uart.c) from linux 2.4.19
and it works fine.

Sylvain

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
