Message-ID: <3F3A208C.7070004@aimsys.nl>
Date: Wed, 13 Aug 2003 13:27:08 +0200
From: Jaap-Jan Boor <jjboor@aimsys.nl>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: jffs2, kupdated and wdog to
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I use a kernel timer (add_timer) to strobe proprietary wdog implemented
in hw. I notice that once in a while when the kupdated task gets busy,
my kernel timer is not called for a long time (400 - 500 ms) because
of jffs2 administration (e.g. jffs2_free_inode_cache).

I still use the Denx 2.4.4 eldk 1.0 kernel. Does somebody know of
a more recent jffs2 that calls schedule() more often or is this
behaviour changed in kernels with the preemptible patch?

In addition, is there a better way to strobe watchdogs then using
a kernel timer?

thanks,

Jaap-Jan

--
J.G.J. Boor			  Anton Philipsweg 1
Software Engineer		  1223 KZ Hilversum
AimSys bv              		  tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   mailto:jjboor@aimsys.nl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
