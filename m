Subject: Re: xfree86/fbdevhw not sending right mode to radeonfb.c
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20011118140926.MNTJ9849.tomts10-srv.bellnexxia.net@there>
References: <20011118140926.MNTJ9849.tomts10-srv.bellnexxia.net@there>
Content-Type: text/plain; charset=ISO-8859-1
Date: 18 Nov 2001 18:31:18 +0100
Message-Id: <1006104678.9556.7.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2001-11-18 at 15:12, Kevin B. Hendricks wrote:
>
> I am still working on the radeon driver for XFree86 and trying to get the
> useFBDev options to work properly.
>
> I have a properly constructued mode line in my XF86Config-4 which I
> specifiy.
>
> However when the XFree86 radeon_driver passes this initial mode to the
> radeonfb.c kernel framebuffer driver, most of the mode information is
> missing (no detailed timing info, just xres and yres, etc.
>
> The radeonfb.c messes up when this incomplete mode information is passed
> to it (from fbdevHWModeInit ?).
>
> So where should I look to see where this is messing up.  It does not
> appear to be an issue with the framebuffer kernel driver since it is the
> victim of the receiving end of the bad data.
>
> It is almost like the the xfree86 code that parses the XF86Config-4 config
> file is not properly grabbing the specific mode information (or somehow
> later it is being mangled).
>
> Any hints or guidance of where to look in xfree86, would be greatly
> appreciated.

fbdevHW and fbdevHWModeInit in particular are probably good places to
start. If you enable debugging in fbdevHW, it will print detailed mode
information.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
