Subject: Re: linuxppc-2.5 (mvista rsync) -- Please push changesets for
	AGPGART / RadeonFB / Radeon DRI to Linus
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Miles Lane <miles.lane@comcast.net>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200308021832.08242.miles.lane@comcast.net>
References: <200308021832.08242.miles.lane@comcast.net>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1059930294.14545.31.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Date: 03 Aug 2003 19:04:54 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2003-08-03 at 03:32, Miles Lane wrote:
>
> When I build and run a Linus kernel 2.5.72 - 2.6.0-test2 kernel,
> the video gets thrown way out of sync when I start my Radeon
> card with DRI enabled.  The symptom is twofold, the colormap
> is all wrong and all I get is a very blurry, oversized pointer.  The
> sync seems to be way out of whack.  Switching to a VT window
> doesn't help.  In fact, the video in VT windows exhibits the
> same problems.  I have tried switching back and forth repeatedly.
> The only thing that fixes the problem is starting XFreee86 with
> DRI disabled or rebooting.

Do you have radeonfb working? If so, I want to see your .config. :)

The radeon DRM should work out of the box in any recent 2.5/2.6 kernel,
the lack of agpgart may be a problem on some machines though. It's hard
to say exactly what's the cause of your problems without knowing
anything about the version of XFree86, its configuration, ... but I'm
not sure that's really on topic for this list...


--
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
