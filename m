Message-ID: <3ACB1FE8.B1CF3592@opensource.se>
Date: Wed, 04 Apr 2001 15:21:44 +0200
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA-ATA DMA and Minix/FATxx
References: <Pine.BSF.4.21.0104041359250.64110-100000@invalid.ed.ntnu.no>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Minix is told to be simple but where is it documented?

I think that the Minix filesystem doesn't specify what endian
to store the data. Storing files on a PC and reading them on
your PowerPC target might be hard...

/ magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
