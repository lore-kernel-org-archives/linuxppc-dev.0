Date: Mon, 17 Nov 2003 09:25:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Dale Farnsworth <dale@farnsworth.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC5200 Patches
Message-ID: <20031117162530.GD30251@ip68-0-152-218.tc.ph.cox.net>
References: <20031117151948.GB30251@ip68-0-152-218.tc.ph.cox.net> <20031117160250.CD994C5F59@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031117160250.CD994C5F59@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 17, 2003 at 05:02:45PM +0100, Wolfgang Denk wrote:
>
> In message <20031117151948.GB30251@ip68-0-152-218.tc.ph.cox.net> you wrote:
> >
> > > > Per your suggestion above, I created
> > > > bk://source.mvista.com/linuxppc_2_4_mpc5200
> > >
> > > Which source tree / change set is this based on?
> >
> > It's semi-moot.  I've created a linux-2.4-mgt5100 tree, based off of
>
> Can you please translate this into English for me?
>
> My question was: is bk://source.mvista.com/linuxppc_2_4_mpc5200  base
> on linuxppc_2_4 or linuxppc_2_4_devel, and which exact ChangeSet.

Dale's is based off of linuxppc_2_4_devel as of 1.3998 I believe.

> Why do you create a new tree ...-mgt5100 ? The MGT5100 can safely  be
> considered  dead  (except that ther eare some systems out there which
> remain being supported),.

It's just a name, and I've renamed it to -mpc5xxx (and changed all refs
ot MGT5100/MGT5200 to MPC5xxx or MPC5100 or MPC5200 (in talking with
Dale 'MGT' seems to be going away as naming, so..).

> > Marcelo's tree to carefully check things into, and hopefully get him to
> > pull from in 2.4.24-pre time-frame.  I'll email everyone again once I've
> > got it populated with stuff from Dale's tree.
>
> Can you please explain the rationale behind  creating  a  new  source
> tree?  There  is  the old bk://source.mvista.com/linuxppc_2_4_mgt5100
> tree, there is now Dave's new  linuxppc_2_4_mpc5200  tree.  There  is
> linux-2.4, linux-2.5, linuxppc_2_4_devel, linuxppc-2.4, linuxppc-2.5.
> There  is  a  couple  other, less official source trees (like Ben's).
> There is our CVS tree.

This is a tree that we can check the initial MPC5xxx work into for 2.4,
make sure that it works and get Marcelo to take it.  Then it can die.
And the older (linuxppc_2_4_mgt5100) can be archived and die.  And the
new (linuxppc_2_4_mpc5200) tree should die now since it's only got
Dale's one patch in it, that I'm moving over.

> And instead of reducing the confusion about all the different  kernel
> source trees you created yet another one?? Why?

Because none of the others can be pulled directly into Marcelo's tree.
IFF we do this right the first time, more or less, in the end I can just
ask Marcelo to give bk://ppc.bkbits.net/linux-2.4-mpc5xxx a pull and
we'll all be happy.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
