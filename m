Date: Fri, 12 Apr 2002 08:08:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: sporadic kernel panic during boot (MPC8xx, FEC)
Message-ID: <20020412150803.GO759@opus.bloom.county>
References: <3CB6A2FE.62FFB14E@imc-berlin.de> <20020412133332.AA7E211258@denx.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020412133332.AA7E211258@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Apr 12, 2002 at 03:33:27PM +0200, Wolfgang Denk wrote:
> In message <3CB6A2FE.62FFB14E@imc-berlin.de> you wrote:
> >
> > But I am still not sure if I understand what that means. Is there a
> > FAQ/README/HowTo about the LinuxPPC/Bitkeeper/Versionnumbering
> > somewhere?
>
> Good question!

Without a real answer, unfortunatly.

> > Which ChangeSet or Tag stands for a stable PPC kernel?
>
> Define stable :-(

Well, whichever ChangeSet is the merge of someplace:/.../linux_2_4 into
someplace:/.../linuxppc_2_4 is the merge into linuxppc_2_4.

> > Which ChangeSet equals (with regard to functionality) the official
> > linux-2.4.18 from kernel.org?
> >
> > Does the ChangesSet 1.900 (which is shortly after Tag 2.4.18) contain
> > all the stuff that's in the offical kernel?
>
> Another "interesting" question: assuming I identif a certain state of
> the tree with Changeset XXX today, how can I find  exactly  the  same
> state  XXX  in  three  monbths,  when  the  changesets  may have been
> renumbered?

Well, ChangeSet 1.900 just happens to be after, but I don't recall the
exact changeset of the 2.4.18 merge.  As for the other question, I
forget the exact command (ask on the bk users list) bk each ChangeSet
has a unique key with it, that does not change, so you can later find
things based on the key.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
