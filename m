To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: tas@mindspring.com (Timothy A. Seufert),
	langausd@fachschaft.informatik.uni-stuttgart.de (Siggi Langauf),
	debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: "Cache Profiler" ? (was: No cache control on ppc??)
References: <200201130651.g0D6pws395601@saturn.cs.uml.edu>
From: Elizabeth Barham <soggytrousers@yahoo.com>
Date: 13 Jan 2002 02:06:45 -0600
In-Reply-To: "Albert D. Cahalan"'s message of "Sun, 13 Jan 2002 01:51:58 -0500 (EST)"
Message-ID: <877kqmvfmy.fsf@yahoo.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I recently installed a NewerTech Maxpowr G3 L2-Cache - which is a G3
on a board that fits into one of the L2's ram banks on my Starmax
3000/160. I was ecstatic that the bogomips increased by 187%
(199.47). Recently, though, I heard of someone installing a JoeBoard
into his StarMax 5000 and his bogomips being around 800. He mentioned
something about a "Cache Profiler". It seems that BootX is somehow
able to tell the kernel that there is a G3 in the cache and speed is
increased greatly.

The CPU on the StarMax 3000/160 motherboard itself (what originally
came with it) is a PPC 603e. /proc/cpuinfo shows a 750 - which is good
but the bogomips are nowhere near what this person reported.  I do not
use BootX for I prefer booting straight into Linux with Quik.  Does
anyone know anymore about this and if it's possible to increase
performance more by somehow making the G3 quicker?

Thank you,
Elizabeth


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
