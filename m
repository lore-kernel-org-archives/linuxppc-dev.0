Message-ID: <3B3EAF46.AF5B0B90@mvista.com>
Date: Sun, 01 Jul 2001 01:04:06 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: (allocating non-cachable memory) (or More on the i82596)
References: <Pine.LNX.3.95.1010629025613.5292B-100000@november.bhjjh.erols.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Justin (Gus) Hurwitz" wrote:

> Dan, Wwhere are the consistent_alloc functions?

They are supposed to be in arch/ppc/mm/ioremap.c, but there has been
lots of work done there recently.  I haven't worked in the tree
recently,
so I'll take a look.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
