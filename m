From: Thomas Capricelli <capricel@enst.fr>
To: linuxppc-dev@lists.linuxppc.org
Subject: long-term 7600-booting patch
Date: Wed, 27 Oct 1999 16:45:44 +0200
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <99102717012102.13242@uranium>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Hi, 

	I've reported this problem many times to linuxppc support,  Paul
Mackerras and some others.

	Since may 1999, my kernel won't boot UNTIL I applied a patch I have
available to anyone who wish.

	The problem (well known) is with the first (internal) SCSI not syncing
at boot time.

	As my 2.1.125 kernel from linuxppc R4 was always fine but I need to
boot new kernels, I've made this patch. Not that I understand a lot of what
i've done, mainly backporting the mesh code from 2.1.125.

	At least, my mac now always BOOT. Before applying this patch, I had to
try between 6 and 16 times to boot my computer. You DON'T know how tiring this
is

Thomas

-- 
Thomas Capricelli

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
