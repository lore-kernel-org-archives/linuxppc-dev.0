Subject: Re: Linux on Force Computers CPCI-3750 eth drivers
From: luca gambazzi <luca.gambazzi@epfl.ch>
To: Matt Porter <porter@cox.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1049880169.3724.16.camel@shampoo.epfl.ch>
Mime-Version: 1.0
Date: 09 Apr 2003 11:22:49 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Matt

I'm booting with the pcore kernel.

the pcore_find_bridges function in pcore_pci.c recognize my card as a
6750, but the 3750 uses a 21150 bridge and not a 21154.

Do you know where can i find documentation to solve this problem?
and where I have to modify?

here you can find the bios log, maybe you can find an answer.
http://lsa1pc32.epfl.ch/~gamba/robox/

Thanks a lot
luca


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
