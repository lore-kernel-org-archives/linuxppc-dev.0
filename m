Date: Wed, 8 Jan 2003 19:22:54 +0100
From: Boris Bezlaj <boris@bandit.kista.gajba.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pantelis Antoniou <panto@intracom.gr>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Status of linuxppc_2.5
Message-ID: <20030108182254.GB1002@bandit.kista.gajba.net>
References: <3E1BECD2.9060909@intracom.gr> <20030108173215.GA1002@bandit.kista.gajba.net> <1042049915.787.9.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1042049915.787.9.camel@zion.wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 08, 2003 at 07:18:35PM +0100, Benjamin Herrenschmidt wrote:
>
> What patch ? I'm interested ;)

It just adds +#include <linux/interrupt.h> to swim3.c

> So far, swim3 in 2.5 is not up-to-date to new BIO semantics in 2.5. I've wanted
> to do that for some time now but didn't find time yet.

But does the writing work in 2.4.x ? For me it works flawlessly in 2.2.x,
but in 2.4 there are some problems with settling (only when writing; read
is fine), which im trying to figure out and fix.

--

With best regards,

		Boris B.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
