From: raphael.bossek@solutions4linux.de
To: linuxppc-embedded@lists.linuxppc.org
Date: Fri, 28 Jan 2000 10:31:23 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Cachable / Non-cachable memory
Message-Id: <E12E7dQ-0004I1-00@mx00.kundenserver.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

how does Linux specify memory regions as cachable and non-
cachable? It is sometimes required to mark mapped memory
regions from devices as non-cachable by the MMU so the PowerPC
does not tune the write/read accesses.

Is there any function or sample driver code in the mpc8xx-linux
2.2.13 code ?

cu Raphael Bossek - http://www.solutions4linux.de/powerpc.html

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
