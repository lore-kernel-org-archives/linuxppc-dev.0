Date: Wed, 23 Jun 1999 11:09:07 +1000
Message-Id: <199906230109.LAA02811@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: jquinn@nortelnetworks.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <376FFF26.A7493FF1@americasm01.nt.com>
	(jquinn@nortelnetworks.com)
Subject: Re: ppp compression module aliases?
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.PMDF.3.96.990622120549.539020675E-100000@uni.edu> <376FFF26.A7493FF1@americasm01.nt.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jerry Quinn <jquinn@nortelnetworks.com> wrote:

> Yes.  modprobe -c doesn't include ppp-compress aliases, at least my
> version doesn't have them.

I have just checked in a change to modutils on vger which adds the
ppp-compress aliases.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
