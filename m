Date: Tue, 7 Aug 2001 14:49:02 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Non-cacheable memory
Message-ID: <Pine.LNX.4.33.0108071444530.16835-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Several weeks ago I was attempting to allocate a region of non-cacheable
memory (required for my 603e based board's ethernet chip) and was told the
work was underway to get support for that into the kernel. I've not
checked up on that progress for a while now, so I thought I'd give it
another try:

Does the current 2_4_devel tree have support for allocating regions of
non-cachable memory? And, if so, what is the proper (or preferred) way of
doing this?

It sure would be nice if I could turn the board's L1 cache back on :)

Thanks,
--Gus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
