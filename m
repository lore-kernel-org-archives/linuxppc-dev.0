From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Crash with BenH's 2.4.10/2.4.11-pre on 7600
Date: Mon, 8 Oct 2001 01:02:41 +0200
Message-Id: <20011007230241.7484@smtp.wanadoo.fr>
In-Reply-To: <200110072050.WAA00644@piglet.grunz.lu>
References: <200110072050.WAA00644@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Loking closely at the kmalloc() code, it seems to crash in the first
>test in kmem_cache_alloc_head(), where it accesses cachep->gfpflags.
>That would mean it hit an unitialized entry in cache_sizes??

Either that or there is some memory corruption going on. Could you
try to compille without CONFIG_KTRAPS (see kernel hacking options) ?

If this doesn't help, please try bk _2_4 and _2_4_devel. The later
one should be pretty similar to my current rsync. However, bk allows
you to extract sources just before my recent pmac push. That would
at least tell us if the crash is related to (pretty huge) changeset
I pushed yesterday or if it's something in .11pre4 PPC that is broken.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
