Date: Thu, 3 Jun 1999 15:23:46 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Paul.Mackerras@cs.anu.edu.au
cc: brad@turbolinux.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: rsync kernel compile fails
In-Reply-To: <199906030558.PAA00552@tango.anu.edu.au>
Message-ID: <Pine.LNX.4.05.9906031521390.731-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 3 Jun 1999, Paul Mackerras wrote:

> I have a 2.3.4 kernel working but without USB.  I plan to work on
> getting the new USB stuff working on the iMac soon.  But in the
> meantime maybe I need to get a recent 2.2.x kernel working with the
> old UUSBD stack.  What I might do actually is kludge the USB keyboard
> driver to convert all the keycodes to ADB keycodes, instead of
> continuing with the multi-keyboard patch.

It's actually not too hard to do.  (I did it to a vger tree for a while).
Just gotta backport the keyboard changes from 2.2.8 (or was it 7 when usb
went in?) and then fix a few problems that will no doubt show up w/ the
multikeyboard patch.  It'll work, and should be good enough until one of
the OHCI drivers in the new USB stack works w/ ppc (tho I suspect it might
be a bit of a pain, w/ the kernel_thread link problem, or whatever it
was...)

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
