Message-Id: <5.1.1.6.0.20021223143800.00acb5a0@dns.struinfo.it>
Date: Mon, 23 Dec 2002 14:49:14 +0100
To: linuxppc-embedded@lists.linuxppc.org
From: llandre <r&d@wawnet.biz>
Subject: Re: Walnut configuration (old problem)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry for my silly question.
I didn't realize that even in the Linux PPC master Makefile it is necessary
to setup the ARCH variable.
Anyway here are the operations I performed in order to build the kernel for
this board (I think this can help other newbies like me):

1) download linuxppc_2_4_devel tree: rsync -avz --delete
source/mvista.com::linuxppc_2_4_devel <destination_directory>
2) make mrproper
3) make walnut_config
4) make oldconfig
5) make dep
6) make pImage


Thanks for the help,

llandre


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
