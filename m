Date: Tue, 14 Aug 2001 20:18:31 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: flush_dcache_range problems
Message-ID: <Pine.LNX.4.33.0108142014130.19084-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Anyone have an idea as to why flush_dcache_range is crashing the kernel on
my 603e based board? It's dying on the "dcbst   r0,r3" instruction. I've
been unable to find any other code that uses this function, so I don't
even know if it works on the 603 at all.

Thoughts?

PS- tomorrow's the last day I'm working on this project, so quick replies
are great :)

Thanks,
--Gus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
