Date: Thu, 12 Aug 1999 15:03:33 +1000
Message-Id: <199908120503.PAA30042@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: iweiny@kdat.csc.calpoly.edu
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <199908120447.VAA18371@kdat.csc.calpoly.edu>
	(iweiny@kdat.csc.calpoly.edu)
Subject: Re: newbee q's? and 2.2 kernels
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <199908120447.VAA18371@kdat.csc.calpoly.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ira K. Weiny <iweiny@kdat.csc.calpoly.edu> wrote:

> I have been trying to install pauls 2.2.10.  I would eventually like to
> compile my own kernel and modules.  Specifically I am going to try and
> fix the pppd from crashing...  Of course if I can...  ;-)

What's the problem with pppd?  It works fine for me, but maybe that's
just because I'm the ppp maintainer :-).

> What does the System.map and module-info files do in the /boot

ps uses /boot/System.map, and complains if it is for a different
version from the currently running kernel.

> directory?  And where can I get some information on kernels and modules?  As
> with most computer stuff the books I have found are outdated for the 2.2
> kernel.

Have a look in the Documentation directory in the kernel sources.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
