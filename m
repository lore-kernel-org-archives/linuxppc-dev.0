Date: Mon, 8 Dec 2003 20:50:32 +0100 (MET)
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: 8270 performance
Message-ID: <Pine.GSO.4.33.0312082046590.3461-100000@sun064.aimsys.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I've a modified 2.4.22 kernel built with gcc 3.3.2
running on a 8270 system here and see the following
cpuinfo:

# cat /proc/cpuinfo
cpu            : 82xx (Hip7)
core clock     : 266 MHz
CPM clock      : 166 MHz
bus clock      : 66 MHz
revision       : 32.17 (pvr 8082 2011)
bogomips       : 175.71

I would expect the bogomips number
to be somewhere near the core clock
(like 8xx).

Any experience? Thanks

Jaap-Jan

---
J.G.J. Boor			  Anton Philipsweg 1
Software Engineer		  1223 KZ Hilversum
AimSys bv              		  tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   mailto:jjboor@aimsys.nl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
