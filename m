Message-ID: <3ADB6887.F67E9DDE@iiic.ethz.ch>
Date: Mon, 16 Apr 2001 23:47:51 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: XF4 (mach64) help please
References: <20010416151514.E88D02F0B6@apollo.valhalla.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:

> 1/  Key-mappings are screwed (big time) with any combination of "Option
> XkbModel" I've tried - this is very unfortunate because I can't do SysRq or
> VT switches - too much time spent watching fsck...

You could try Option "XkbDisable" until you know how to configure XKB (I still
use it ;).


> 2/  The Mach64 driver is not loading.
>
> 3/  The fbdev driver loads & runs but usually crashes on X restart (which
> occurs on log-out) - leaving me with a locked machine and another fsck...

I beg your pardon? :) I'd be interested to see a log of that, preferrably with
debugging output enabled, but this smells like a framebuffer device bug.


> fbdevHWInit failed
> crapping out here

Do you use atyfb in console? The ati driver only works with that with option
"UseFBDev". No idea what it will do without that option, you'd have to find
out.


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
