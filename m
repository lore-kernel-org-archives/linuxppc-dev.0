Subject: Re: Status of linuxppc_2.5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Boris Bezlaj <boris@bandit.kista.gajba.net>
Cc: Pantelis Antoniou <panto@intracom.gr>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030108173215.GA1002@bandit.kista.gajba.net>
References: <3E1BECD2.9060909@intracom.gr>
	 <20030108173215.GA1002@bandit.kista.gajba.net>
Content-Type: text/plain
Message-Id: <1042049915.787.9.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 08 Jan 2003 19:18:35 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-01-08 at 18:32, Boris Bezlaj wrote:
> On Wed, Jan 08, 2003 at 11:18:10AM +0200, Pantelis Antoniou wrote:
>
> > BTW, are there any gotchas, or anything
> > I should pay attention moving
> > from 2.4 -> 2.5?
>
> AFAIK, you need the new module-init-tools for loading/unloading modules.
>
> I see there is a little patch for swim3 driver. Do you have any problems
> with swim3 driver in 2.4 kernel when writing to floppy? What is the status
> in v2.5?

What patch ? I'm interested ;)

So far, swim3 in 2.5 is not up-to-date to new BIO semantics in 2.5. I've wanted
to do that for some time now but didn't find time yet.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
