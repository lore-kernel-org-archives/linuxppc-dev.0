Message-ID: <3ADCC067.5D7CE81F@iiic.ethz.ch>
Date: Wed, 18 Apr 2001 00:15:03 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
References: <20010417211637.DEDEEDBA73@atlas.valhalla.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:

> I haven't been able to try Ani's patch yet - the xfree86.org cvs server
> pings - but no response yet today to cvs login :-(

Yup, seems to be down again. :( Can you try the other methods or a mirror?


> ati (mach64): (G3/beige, 2.4.4-pre3)
>
> a kludge of putting the 4.0.99.1-0f libfbdevhw.a library into the latest
> code gives me ati accel.

The only changes between 4.0.99.1 and .2 there are an added function and two
cast changes from unsigned int to unsigned long, so I suspect the version that
works for you has been patched. I'd be interested to see those patches and
possibly include them for the 4.1.0 release.


> Michel's advice to "option XkbDisable" gives partial functionality (VT
> switches, server re-start).... but... with no mouse button emulation or
> SysRq. (haven't tried MoL yet).

The latter two aren't X but kernel issues.


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
