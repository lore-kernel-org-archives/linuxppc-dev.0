Date: Fri, 12 Apr 2002 10:13:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: sporadic kernel panic during boot (MPC8xx, FEC)
Message-ID: <20020412171338.GS759@opus.bloom.county>
References: <20020412150803.GO759@opus.bloom.county> <20020412152559.DBE0A1125A@denx.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020412152559.DBE0A1125A@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Apr 12, 2002 at 05:25:54PM +0200, Wolfgang Denk wrote:
> In message <20020412150803.GO759@opus.bloom.county> you wrote:
> >
> > > Another "interesting" question: assuming I identif a certain state of
> > > the tree with Changeset XXX today, how can I find  exactly  the  same
> > > state  XXX  in  three  monbths,  when  the  changesets  may have been
> > > renumbered?
> >
> > Well, ChangeSet 1.900 just happens to be after, but I don't recall the
> > exact changeset of the 2.4.18 merge.  As for the other question, I
> > forget the exact command (ask on the bk users list) bk each ChangeSet
> > has a unique key with it, that does not change, so you can later find
> > things based on the key.
>
> I know how to find the key:
>
> 	$ bk prs -d ':KEY:\n' -r1.900 ChangeSet
> 	======== ChangeSet 1.900 ========
> 	trini@opus.bloom.county|ChangeSet|20020227003717|01133
>
>
> I _think_ I should be able to perform the reverse operation using "bk
> key2rev", but I never understood how to use this command.

Okay, I think I just figured it out (the help page sucks..):
$ bk get ChangeSet
ChangeSet 1.944: 11970 lines
# escaped for bash's sake
$ echo trini@opus.bloom.county\|ChangeSet\|20020227003717\|01133 | bk key2rev ChangeSet
1.900

Or bk key2rev ChangeSet, and enter the keys

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
