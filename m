Message-ID: <20030728065950.54021.qmail@web20205.mail.yahoo.com>
Date: Sun, 27 Jul 2003 23:59:50 -0700 (PDT)
From: Raghava Vatsavayi <rajuraghava@yahoo.com>
Subject: DMA alignment????
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Our ethernet driver performance is not so good in
powerpc machines. I have attached a link for a patch
and brief description below, which talks about
alignment of dma memory for rx and tx buffers.
So my question is, Will there be increase in
performance on powerpc machines if I also align my
tx/rx dma pointers?????



Description:
PCI bridge peculiarities mean the insufficiently
aligned DMAs perform terribly on Power4 hardware. This
hack copies and realigns packets to improve
performance.


http://oss.software.ibm.com/linux/patches/?patch_id=881


Please mail me at rajuraghava@yahoo.com

Cheers
Raghav.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
