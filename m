Date: Wed, 11 Jul 2001 08:58:35 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: How fast should a bogomip be
Message-ID: <Pine.LNX.3.95.1010711084748.21073D-100000@november.bhjjh.erols.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


First off- let me run for cover while saying that I know bogomips are
relatively arbitrary numbers.

I've seen numbers that indicate on 6xx series processors bogomips is
usually about 2/3 the processor speed- so about 66.6 for a 100Mhz
processor. I hope this is accurate, because that's what I'm getting.

But, about what should I expect for a 6xx (603e) 100Mhz processor running
without cache? I've been trying to disable cache so I can continue
development until the kernel supports propper allocation of non-cacheable
memory (on a 603e with broken memory controller). When I run the kernel
with code changes that *should* disable the cache the bootup process does
feel marginally slower, and bogomips goes down a whopping .64 (from 66.56
to 65.92). It then crashes with a segfault in kupdated (when in _wake_up).
And I've been scratching my head trying to figure out a) whether the
caches are actually disabled b) what causes that segfault, and c) how the
two are related.

Any feedback it appreciated,
--Gus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
