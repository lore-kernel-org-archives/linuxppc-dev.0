Date: Thu, 3 Jun 1999 22:17:56 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Paul.Mackerras@cs.anu.edu.au
cc: brad@turbolinux.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: rsync kernel compile fails
In-Reply-To: <199906040202.MAA04489@tango.anu.edu.au>
Message-ID: <Pine.LNX.4.05.9906032215000.642-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 4 Jun 1999, Paul Mackerras wrote:

> Tom Rini <tmrini@ntplx.net> wrote:
> 
> > It's actually not too hard to do.  (I did it to a vger tree for a while).
> > Just gotta backport the keyboard changes from 2.2.8 (or was it 7 when usb
> > went in?) and then fix a few problems that will no doubt show up w/ the
> > multikeyboard patch.  It'll work, and should be good enough until one of
> > the OHCI drivers in the new USB stack works w/ ppc (tho I suspect it might
> > be a bit of a pain, w/ the kernel_thread link problem, or whatever it
> > was...)
> 
> Do you have a recent 2.2.x tree that all works?

I might have a 2.2.7 or 8 tree someplace w/ uusbd patched back in.  I
don't have anything w/ Linus' usb stack working.  (Looked at it and
figured I could wait until I had a pmac again).

> The reason I was thinking of converting the USB keycodes to ADB
> keycodes is that that is what will have to happen with the new USB
> stack (either that or converting everything to PC keycodes, which will
> break a lot of things).

I haven't looked at the current USB stack, but if it does what you seem to
be implying (changing the keycodes into their normal PC equiv) it's doing
something Wrong.  I'll go and skim what's in vger shortly..

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
