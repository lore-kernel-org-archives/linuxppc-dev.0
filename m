Date: Mon, 14 Feb 2000 19:51:25 +0100 (MET)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
Reply-To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Atherosclerotic Linux Mice Uni-Mouse Only ...
In-Reply-To: <200002130600.AAA05020@lists.linuxppc.org>
Message-ID: <Pine.SOL.3.95.1000214192157.7820D-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 12 Feb 2000 08:44:15 -0800, Jeremy Knope <swttiggr2@yahoo.com> wrote:
>
> I'm using an XLR8 Point&Scroll mouse... works great.
> plugged it in... booted linux... worked! now if i only
> could get the scroll wheel to work... pressing it is a
> button tho so it's a full 3 button mouse. there are
> things for scroll wheels in linux but not sure if
> it'll work. specially cuz the one i found uses
> XF86Config, i'm using Xpmac which i seemed to read
> that it doesn't use that file.

Yep, I'm not aware of any way to use it with Xpmac. With XF68_FBDev it's
working great. Now, if I could only get the wheel recognized in /dev/gpmdata!
When I pass the mouse input through gpm to use th usb mouse and the
trackpad, the wheel doesn't work. I've already installed a patched gpm
from debian (in /debian/dists/potato/main/source/misc/gpm_1.17.8.*) that's
supposed to fix this, but gpm still either doesn't repat the wheel action
properly or XFree doesn't recognize it. Maybe all it would take is to have
XFree read /dev/gpmdata in "IMPS/2" protocoll (currently this only works
with "MouseSystems")? Any ideas?

>
> - --- NTR <ntr@mindmachine.com> wrote:
> > Dear Uni Mouse Fanatics,
> >
What's the Uni Mouse?

> > Is this the only mouse that will work in 3 button
> > mode for Linux....or
> > will any USB Mouse work.
> >
> > I am particular towards the Kensington Turbo Ball
> > for purely
> > atherosclerotic reasons.  You move your palm or
> > fingers, not your whole
> > hand and elbow.  Helps keep the years off my
> > wrist/elbow replacement  Its
> > USB.  Will it work?
> >
Like these, too. I've a Logitech ADB Trackman on my old 8100. Wish I'd find
such a thing for my PB.

Greetings,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
