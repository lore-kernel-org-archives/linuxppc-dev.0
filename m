Subject: Re: Rage128 support for resolutions less than panel resolution?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20011204175547.WVJL16262.tomts14-srv.bellnexxia.net@there>
References: <Pine.LNX.4.40.0112041017530.8200-100000@andromeda.dsdk12.net>
	<20011204175547.WVJL16262.tomts14-srv.bellnexxia.net@there>
Content-Type: text/plain; charset=ISO-8859-1
Date: 05 Dec 2001 00:47:45 +0100
Message-Id: <1007509665.21511.38.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2001-12-04 at 18:58, Kevin B. Hendricks wrote:

> However if you have the correct timing info, you should be able to write a
> mode to use and then use fbset to set rage128 frame buffer to that mode.
>
> This should work to change your resolution to whatever you want as long as
> the "scaling register code" patch I saw fly by recently (a couple of weeks
> ago) actually made it into the aty128fb.c code yet.
>
> If it did you should be in luck.  Just take the timing from the the full
> native resolution and just change the x and y resolution and leave all of
> the rest untouched.  The scaling registers code should figure out the rest.
> as long as the real native panel resolution is known by the driver.

Thanks for these instructions Kevin! I'm now able to use 800x600 and
640x480 on my Pismo without any flickering and artifacts.

One thing I noticed is that when I use the timings from 1024x768-60 for
640x480, the vertical refresh is shown as 130 Hz. That doesn't harm the
panel?


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
