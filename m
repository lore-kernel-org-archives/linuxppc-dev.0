Message-ID: <396504F6.8C36D79C@m2tech.co.nz>
Date: Fri, 07 Jul 2000 10:15:18 +1200
From: ben bodley <benb@m2tech.co.nz>
MIME-Version: 1.0
To: mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: ide driver - where do i start?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello all!

listen, we are using a ppc 403gcx running at 80 mips, and have connected
an ide drive straight up to the data bus (through some buffers)..

i can look at the driver command/control registers fine as memory mapped
i/o, etc.. the hd is dma-able and the interface is setup to be stable at
pio4 possibly udma/33..

the next step for me is to modify the linux ide code to talk to my
drive.. has anyone hooked up ide directly to the processor bus?? i am
currently looking at basing my code off drivers/block/ide-pmac.c and
changing the probe and dma code to fit.. is this the place to start??

cheers for any insights,

--
/\\------------------------------------------------------------------
:::::::::::..ben.b..m2technologyltd.nz..64.9.4448307.130..:::::::::::


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
