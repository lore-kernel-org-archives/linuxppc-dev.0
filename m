Message-ID: <395527BA.3E61D7BC@wanadoo.fr>
Date: Sat, 24 Jun 2000 23:27:22 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Accessing IO space via resources
References: <200006240632.IAA00722@piglet.grunz.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:

> After investigating this, it turns out that early in the boot process,
> before the mm system is up, ioremap returns virt == phys for
> addresses >= ioremap_base. ioremap_base got changed from 0xf8000000 to
> 0xf0000000 in recent kernels. Anybody kow why this got changed?

Browsing bk diffs (BTW, it's rather the other way round), this looks
very much like a typo. Paulus, on 06/09/2000, cleaning up too
thoroughly?

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
