Date: Mon, 2 Jul 2001 06:10:17 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: mmu_decl.h- missing semi (was: Current state of the 2_4_devel tree)
Message-ID: <Pine.LNX.3.95.1010702060805.4368D-100000@november.bhjjh.erols.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I found the cause of the compile error I was having- there is a missing
semi-colon after the setbat() declaration in arch/pp/mm/mmu_decl.h.
Someone with write access might want to fix that (unless the kernel isn't
supposed to compile :)

--Gus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
