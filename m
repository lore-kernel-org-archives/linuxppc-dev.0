Message-Id: <v04003a03b4c65abdedd2@[216.81.17.138]>
In-Reply-To: <20000208233709.17120.qmail@web1001.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 8 Feb 2000 18:13:56 -0600
To: Dan Bethe <dan_bethe@yahoo.com>
From: Tony Mantler <eek@escape.ca>
Subject: Re: the state of the linuxppc-dev community
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 5:37 PM -0600 2/8/2000, Dan Bethe wrote:
[...]
>	The problem is that LinuxPPC.org has a development environment that is
>splintered, unstable, undocumented, obscure, nonintuitive, and basically
>impenetrable even to people who are fully dedicated to it such as Gabe and
>myself.  It is run almost exclusively on tribal knowledge that is only in the
>heads of the people who are writing the ppc-specific core of the OS.
>There are
>no procedures and no interface.  And there is very little respect toward
>people
>like me and Gabe who have the time, dedication, and skills to clean it all up.
[...]

I've noticed that it can be a bit of a task trying to keep up with what's
happening in the PPC-Linux kernel. I found myself in a somewhat similar
position a year or so ago on the Mac68k-Linux project.

That problem was solved when we (Mac68k) moved the development to a CVS server.

Mind you, the PPC-Linux rsync server makes it very easy to get the
latest-ish kernel sources, which I used quite successfully recently to
compile a kernel for my friend's PBG3. (well, mostly successful. got some
missing symbols from some unimportant modules that I didn't care to track
down. used the benh sources)

However, I find that CVS makes it a lot easier to keep track of what's
going on, especially with a CVS mailing list, which reports all updates to
the repository.


All in all I'm not really complaining, though it would be nice if there was
a centralized place where all the updates relating to the (various) PPC
kernel tree(s) were logged.

That's my 2c.


Cheers - Tony :)


--
Tony Mantler         Renaissance Nerd Extraordinaire         eek@escape.ca
Winnipeg, Manitoba, Canada                       http://www.escape.ca/~eek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
