Date: Fri, 4 Jun 1999 12:02:10 +1000
Message-Id: <199906040202.MAA04489@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: tmrini@ntplx.net
CC: brad@turbolinux.com, linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.LNX.4.05.9906031521390.731-100000@pc.wackyland.com>
	(message from Tom Rini on Thu, 3 Jun 1999 15:23:46 -0400 (EDT))
Subject: Re: rsync kernel compile fails
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.05.9906031521390.731-100000@pc.wackyland.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <tmrini@ntplx.net> wrote:

> It's actually not too hard to do.  (I did it to a vger tree for a while).
> Just gotta backport the keyboard changes from 2.2.8 (or was it 7 when usb
> went in?) and then fix a few problems that will no doubt show up w/ the
> multikeyboard patch.  It'll work, and should be good enough until one of
> the OHCI drivers in the new USB stack works w/ ppc (tho I suspect it might
> be a bit of a pain, w/ the kernel_thread link problem, or whatever it
> was...)

Do you have a recent 2.2.x tree that all works?

The reason I was thinking of converting the USB keycodes to ADB
keycodes is that that is what will have to happen with the new USB
stack (either that or converting everything to PC keycodes, which will
break a lot of things).

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
