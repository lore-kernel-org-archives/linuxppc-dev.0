Date: Thu, 22 Nov 2001 00:59:12 +0000 (GMT)
From: Phillip Lougher <phillip@lougher.demon.co.uk>
To: linuxppc-embedded@lists.linuxppc.org
Subject: linuxppc_2_4_devel vs MontaVista STB3xxxx kernel
Message-ID: <Pine.LNX.4.21.0111220032220.1377-100000@lougher.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have been working on the MontaVista 2_4_2 STB3xxx kernel (the 'official'
kernel for the board).  I have, however, recently downloaded the
2_4_devel kernel.  This appears to now have quite mature support for the
STB3xxx (aka Redwood-4) and the Oak board (403GCX).  I downloaded the
2_4_devel kernel a few months ago, and it then certainly didn't work on
the STB3xxx.

I am now left wondering whether it may be better to move over to
the 2_4_devel kernel for the STB3xxxx and for further kernel
work I need to do for different 4xx chips.  I have specifically the
following questions:

1.  Does the 2_4_devel kernel work on the STB3xxx?
2.  Does the 2_4_devel kernel work on the 403GCX (Oak)?

Obviously, you may wonder, why don't I simply compile it and test.
However, I need to alter the 2_4_devel kernel to run on our
STB3xxxx boards (specifically the bootloader, as the treeboot loader
cannot be used).  Being very pushed for time (I need to get a new kernel
working in < 3 weeks),  I cannot afford to alter the 2_4_devel kernel in
the hope it will work.

The 2_4_2 MontaVista kernel has the advantage that I'm very familiar
with the low-level 4xx stuff, the 2_4_devel is an unknown.  However,
the 2_4_devel kernel certainly seems more mature in respect to the
cleaner integration of 405/403 implementation differences.

Thanks for any advice.

Phillip

----
Phillip Lougher
Zarlink Semiconductor,
Portskewitt, Wales.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
