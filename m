Date: Fri, 4 Jun 1999 12:37:36 +1000
Message-Id: <199906040237.MAA00492@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: tmrini@ntplx.net
CC: brad@turbolinux.com, linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.LNX.4.05.9906032215000.642-100000@pc.wackyland.com>
	(message from Tom Rini on Thu, 3 Jun 1999 22:17:56 -0400 (EDT))
Subject: Re: rsync kernel compile fails
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.05.9906032215000.642-100000@pc.wackyland.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <tmrini@ntplx.net> wrote:

> I haven't looked at the current USB stack, but if it does what you seem to
> be implying (changing the keycodes into their normal PC equiv) it's doing
> something Wrong.  I'll go and skim what's in vger shortly..

That's what it does all right.  I don't like it either but I don't
hold much hope of changing it.  I figure the best we will be able to
do is to change the USB keycodes into ADB keycodes instead of PC
keycodes.  That way the existing keymaps etc. should still work.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
