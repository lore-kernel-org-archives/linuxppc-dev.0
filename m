Message-Id: <200103062315.SAA01659@p2.parker.boston.ma.us>
To: linuxppc-dev@lists.linuxppc.org
Subject: asm/io.h; why does writel() write an le32 on ppc?
Date: Tue, 06 Mar 2001 18:15:01 -0500
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sorry to be daft, but why does writel() write an le32 on the ppc?

in asm/io.h it uses out_le32, unless the machine is an APUS, in which
case it just writes big endian...

(is PCI defined as little endian?)

-brad


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
