From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>,
	<linuxppc-dev@lists.linuxppc.org>, Michel Lanners <mlan@cpu.lu>
Subject: Re: Crash on BenH's latest rsync (2.4.6-pre3)
Date: Tue, 26 Jun 2001 22:51:47 +0200
Message-Id: <20010626205147.26310@smtp.wanadoo.fr>
In-Reply-To: <20010626121003.D31231@opus.bloom.county>
References: <20010626121003.D31231@opus.bloom.county>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Not this one in particular, but I'm tracking 2 different oopses w/
>the tree on a new iBook right now.  2.4.5-pre3 is rock solid too :)
>
>How did you get that oops?  There seems to be a problem w/ inserting
>power to a sleeping 'book.  Or at least w/ this one.

The biggest difference between 2.4.5-pre3 and my current tree is
(except from linux maintstream changes) the new MM layer and
merging of all the linuxppc_2_4_devel work.

It would be helpful for me if you could both try out the current
_2_4_devel tree and tell me if it exhibit the same symtoms. Well,
I beleive sleep won't work on the iBook, so that cannot be tested,
but at least Michel can try it out and tell me.

I currently fail to see what in my recent changes could explain
such weird/random crashes. As far as the iBook is concerned, it
may well be yet another HW issue with a device playing mad
tricks to memory, but I still doubt it.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
