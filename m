Subject: Re: Status of linuxppc_2.5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Boris Bezlaj <boris@bandit.kista.gajba.net>
Cc: Pantelis Antoniou <panto@intracom.gr>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030108182254.GB1002@bandit.kista.gajba.net>
References: <3E1BECD2.9060909@intracom.gr>
	 <20030108173215.GA1002@bandit.kista.gajba.net>
	 <1042049915.787.9.camel@zion.wanadoo.fr>
	 <20030108182254.GB1002@bandit.kista.gajba.net>
Content-Type: text/plain
Message-Id: <1042050862.782.12.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 08 Jan 2003 19:34:22 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-01-08 at 19:22, Boris Bezlaj wrote:
> On Wed, Jan 08, 2003 at 07:18:35PM +0100, Benjamin Herrenschmidt wrote:
> >
> > What patch ? I'm interested ;)
>
> It just adds +#include <linux/interrupt.h> to swim3.c
>
> > So far, swim3 in 2.5 is not up-to-date to new BIO semantics in 2.5. I've wanted
> > to do that for some time now but didn't find time yet.
>
> But does the writing work in 2.4.x ? For me it works flawlessly in 2.2.x,
> but in 2.4 there are some problems with settling (only when writing; read
> is fine), which im trying to figure out and fix.

Did didn't try that driver very hard lately. Please cc me any fix you
may have.

Note also that there is a darwin driver for swim3 floating around that
gets a lot of code from MacOS 9 and that appear to document a bunch
of black magic stuffs, so that may be a good source of information. I
think it's on mklinux.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
