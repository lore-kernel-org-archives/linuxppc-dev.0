Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org
Subject: xfree86/fbdevhw not sending right mode to radeonfb.c
Date: Sun, 18 Nov 2001 09:12:12 -0500
MIME-Version: 1.0
Message-Id: <20011118140926.MNTJ9849.tomts10-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I am still working on the radeon driver for XFree86 and trying to get the
useFBDev options to work properly.

I have a properly constructued mode line in my XF86Config-4 which I
specifiy.

However when the XFree86 radeon_driver passes this initial mode to the
radeonfb.c kernel framebuffer driver, most of the mode information is
missing (no detailed timing info, just xres and yres, etc.

The radeonfb.c messes up when this incomplete mode information is passed
to it (from fbdevHWModeInit ?).

So where should I look to see where this is messing up.  It does not
appear to be an issue with the framebuffer kernel driver since it is the
victim of the receiving end of the bad data.

It is almost like the the xfree86 code that parses the XF86Config-4 config
file is not properly grabbing the specific mode information (or somehow
later it is being mangled).

Any hints or guidance of where to look in xfree86, would be greatly
appreciated.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
