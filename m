Message-Id: <199905170728.JAA03775@denx.muc.de>
To: Tom Rini <tmrini@ntplx.net>
cc: linuxppc-dev@lists.linuxppc.org, dev@kernel.crashing.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: LinuxPPC-DR-1.0: X11 config for Powerbook G3 series? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 16 May 1999 20:50:26 EDT."
             <Pine.LNX.4.05.9905162049010.651-100000@pc.wackyland.com>
Date: Mon, 17 May 1999 09:28:01 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

in message <Pine.LNX.4.05.9905162049010.651-100000@pc.wackyland.com> you write:
> 
> > 	(--) FBDev: Mode "1024x768" needs hsync freq of 93.99 kHz. Deleted.
> ...
> > [root@luke X11]# cat XF86Config
> ...
> >     HorizSync   119
> 
> Change that.

Doing this, the next error message is "needs vsync freq of 116.32 Hz".

Changing this parameter also gives:

	XF86Config: /usr/X11R6/lib/X11/XF86Config
	(**) stands for supplied, (--) stands for probed/default values
	(**) XKB: keycodes: "macintosh"
	(**) XKB: types: "default"
	(**) XKB: compat: "default"
	(**) XKB: symbols: "macintosh/us"
	(**) XKB: geometry: "macintosh"
	(**) XKB: rules: "xfree86"
	(**) XKB: model: "pc101"
	(**) Mouse: type: BusMouse, device: /dev/mouse, buttons: 3
	(**) Mouse: 3 button emulation (timeout: 50ms)
	(**) FBDev: Graphics device ID: "OFfb ATY,RageLT"
	(**) FBDev: Monitor ID: "Apple PowerBook G3"
	(**) FontPath set to "unix/:-1"
	(**) FBDev: Using XF86Config video mode database

	Fatal server error:
	No valid modes found.

Sigh... as long as X11 configuration stays  this  error  prone  Linux
will have hard times to beat M$.

Wolfgang

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"I haven't lost my mind - it's backed up on tape somewhere."

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
