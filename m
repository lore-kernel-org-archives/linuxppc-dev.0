To: Tom Rini <trini@kernel.crashing.org>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: sporadic kernel panic during boot (MPC8xx, FEC) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 12 Apr 2002 08:08:03 PDT."
             <20020412150803.GO759@opus.bloom.county>
Date: Fri, 12 Apr 2002 17:25:54 +0200
Message-Id: <20020412152559.DBE0A1125A@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20020412150803.GO759@opus.bloom.county> you wrote:
>
> > Another "interesting" question: assuming I identif a certain state of
> > the tree with Changeset XXX today, how can I find  exactly  the  same
> > state  XXX  in  three  monbths,  when  the  changesets  may have been
> > renumbered?
>
> Well, ChangeSet 1.900 just happens to be after, but I don't recall the
> exact changeset of the 2.4.18 merge.  As for the other question, I
> forget the exact command (ask on the bk users list) bk each ChangeSet
> has a unique key with it, that does not change, so you can later find
> things based on the key.

I know how to find the key:

	$ bk prs -d ':KEY:\n' -r1.900 ChangeSet
	======== ChangeSet 1.900 ========
	trini@opus.bloom.county|ChangeSet|20020227003717|01133


I _think_ I should be able to perform the reverse operation using "bk
key2rev", but I never understood how to use this command.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There's nothing  disgusting  about  it  [the  Companion].  It's  just
another life form, that's all. You get used to those things.
	-- McCoy, "Metamorphosis", stardate 3219.8

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
