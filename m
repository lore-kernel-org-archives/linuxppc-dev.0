Date: Sat, 24 Jul 1999 11:14:01 +1000
Message-Id: <199907240114.LAA01151@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: bh40@calva.net
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <19990723144647.023789@mail.mipsys.com> (message from Benjamin
	Herrenschmidt on Fri, 23 Jul 1999 14:46:47 +0200)
Subject: Re: vger 2.2.10 compile failures
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <19990723144647.023789@mail.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <bh40@calva.net> wrote:

> I'm getting link errors when compiling today's vger 2.2.10 with xmon
> support enabled:
> 
> arch/ppc/xmon/x.o: In function `backtrace':
> arch/ppc/xmon/x.o(.text+0x129e): undefined reference to `ret_from_int'

I got tricked by cvs about this, maybe you have too.  I had a stable
(linux_2_2) cvs tree, and when I did `cvs update -dP', I got an xmon
directory, but it was the xmon from the head of the tree, i.e. the
devel branch.  I should have been doing `cvs update -dP -rlinux_2_2',
of course.  If you do that it should give you the xmon from the stable
branch (which didn't actually exist until yesterday, but now has the
xmon.c with the correct contents).

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
