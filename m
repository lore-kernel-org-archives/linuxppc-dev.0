Date: Sun, 24 Jan 1999 10:25:08 +1100
Message-Id: <199901232325.KAA18504@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: hozer@drgw.net
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.LNX.4.04.9901222349480.17601-100000@narn.local.drgw.net>
	(message from Troy Benjegerdes on Fri, 22 Jan 1999 23:54:16 -0600
	(CST))
Subject: Re: kswapd and SMP still broke on 2.2.0-pre9
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.04.9901222349480.17601-100000@narn.local.drgw.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Troy Benjegerdes <hozer@drgw.net> wrote:

> Can anyone verify 2.2.0-pre9 works on a SMP Pmac? (or for that matter,
> vger.. if vger works I can figure out what changed)

Both 2.2.0-pre9 and vger work fine on my 2-processor powermac.  I do
have some local changes in my tree to do with some extra memory
barriers etc., but I haven't changed kswapd.  You could try rsyncing
my current tree from samba.anu.edu.au::linux-pmac-devel to see my
changes.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
