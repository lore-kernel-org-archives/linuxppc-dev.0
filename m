Date: Wed, 8 Jan 2003 20:30:29 +0100
From: Boris Bezlaj <boris@bandit.kista.gajba.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pantelis Antoniou <panto@intracom.gr>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Status of linuxppc_2.5
Message-ID: <20030108193029.GC1002@bandit.kista.gajba.net>
References: <3E1BECD2.9060909@intracom.gr> <20030108173215.GA1002@bandit.kista.gajba.net> <1042049915.787.9.camel@zion.wanadoo.fr> <20030108182254.GB1002@bandit.kista.gajba.net> <1042050862.782.12.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1042050862.782.12.camel@zion.wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 08, 2003 at 07:34:22PM +0100, Benjamin Herrenschmidt wrote:
> >
> > But does the writing work in 2.4.x ? For me it works flawlessly in 2.2.x,
> > but in 2.4 there are some problems with settling (only when writing; read
> > is fine), which im trying to figure out and fix.
>
> Did didn't try that driver very hard lately. Please cc me any fix you
> may have.

None for now..didn't found the problem yet..i will let you know when
(if) i produce a fix.
>
> Note also that there is a darwin driver for swim3 floating around that
> gets a lot of code from MacOS 9 and that appear to document a bunch
> of black magic stuffs, so that may be a good source of information. I
> think it's on mklinux.org

It is..looks tasty too. I will look into it.

--

With best regards,

		Boris B.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
