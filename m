Date: Mon, 7 May 2001 14:30:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@mvista.com>
Cc: Eli Chen <eli@routefree.com>, brian.kuschak@skystream.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
Message-ID: <20010507143047.B1118@opus.bloom.county>
References: <027b01c0d728$9a702b80$4b00000a@foolio1> <3AF710DC.37209810@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3AF710DC.37209810@mvista.com>; from dan@mvista.com on Mon, May 07, 2001 at 05:17:16PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, May 07, 2001 at 05:17:16PM -0400, Dan Malek wrote:

> > ...  This is really just a work around for us until we find out what
> > is the real problem.
>
> Is there some simple test I can use to trigger this problem?  It
> would be nice if you could try a "newer" kernel from FSM Labs.  This
> was originally in the linuxppc_2_5 tree, and we are merging/changing
> trees at the moment.  I don't remember the URL......TOM, can you
> provide some insight?

Er, 2_5 isn't unavailable yet.  bk://source.mvista.com/linuxppc_2_5 (mirror)
or bk://bitkeeper.fsmlabs.com:5005 (master).  But 2_5 is 'dead' in the sense
that stuff is being moved to a new tree.  The new tree should be a lot more
populated (with new 6xx/7xx/74xx, 8xx, 82xx and some 4xx) stuff after my
finals (And I've got 2 tomorrow, so adios. :))

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
