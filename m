Date: Tue, 12 Nov 2002 14:28:52 +0100 (MET)
Message-Id: <200211121328.gACDSqp17587@hzsc257.nl.lucent.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: jffs2 as root
From: Jaap-Jan Boor <jjboor@lucent.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm using a jffs2 fs on mtd now as my root fs.

To be able to do that however, I patched
the root_dev_names[] table in init/main.c
to at a mtd device with a hardcoded major/minor set.

I pass root=/dev/mtd to the kernel.

There should be a more elegant way, does somebody
know which one?

thanks,

Jaap-Jan

---
J.G.J. Boor
Lucent Technologies Nederland b.v.	Room:  BE-525
Optical Networking Group TMS Data 	Phone: +31 (0)35 687 4721
Larenseweg 50, P.O. Box 1168, 		Fax:   +31 (0)35 687 5976
1200 BD, Hilversum, The Netherlands	mailto:jjboor@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
