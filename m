Date: Thu, 3 Jun 1999 22:57:09 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Paul.Mackerras@cs.anu.edu.au
cc: brad@turbolinux.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: rsync kernel compile fails
In-Reply-To: <199906040237.MAA00492@tango.anu.edu.au>
Message-ID: <Pine.LNX.4.05.9906032255040.642-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 4 Jun 1999, Paul Mackerras wrote:

> Tom Rini <tmrini@ntplx.net> wrote:
> 
> > I haven't looked at the current USB stack, but if it does what you seem to
> > be implying (changing the keycodes into their normal PC equiv) it's doing
> > something Wrong.  I'll go and skim what's in vger shortly..
> 
> That's what it does all right.  I don't like it either but I don't
> hold much hope of changing it.  I figure the best we will be able to
> do is to change the USB keycodes into ADB keycodes instead of PC
> keycodes.  That way the existing keymaps etc. should still work.

Has anyone found out just why that's being done?   It doesn't really make
sense.  There's already usb keymaps for the things that would need 'em.
Perhaps a plea for sanity on linux-usb before things become too set in
stone?

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
