Subject: pcmcia microdrive support on 2.4.21-rev5 for arctic2
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF5A440509.F12D8E5A-ON87256CF6.0080427D-85256CF6.00811364@us.ibm.com>
From: John F Davis <johndavi@us.ibm.com>
Date: Thu, 27 Mar 2003 18:29:33 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello

I am trying to get my microdrive working with 2.4.21.rev5.  I have the
following config options set:
CONFIG_PCMCIA=m
CONFIG_PCMCIA_PCCF_4xx=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDECS=m

I can insmod pcmcia_core, pccf_4xx, and ds.

I built the latest pcmcia package from sourceforge in order to get cardmgr.

When I insert my microdrive, it says "insmod ide_cs.o" no module by that
name found.
I indeed do not have this module in my tree.  What's the deal?


FWIW, I tried building 2.4.17 kernel from kernel.org but it had the same
result.

JD


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
