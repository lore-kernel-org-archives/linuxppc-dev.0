Subject: Re: xfree86/fbdevhw not sending right mode to radeonfb.c
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20011121193918.PTJS24249.tomts11-srv.bellnexxia.net@there>
References: <Pine.LNX.4.33.0111191248340.10443-100000@idd-01.imbc.gr>
	<20011121193918.PTJS24249.tomts11-srv.bellnexxia.net@there>
Content-Type: text/plain; charset=ISO-8859-1
Date: 24 Nov 2001 18:38:42 +0100
Message-Id: <1006623522.24435.63.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2001-11-21 at 20:42, Kevin B. Hendricks wrote:

> FYI: Well I finally figured out what was up.  It seems the first thing the
> special code for "DFPValidateModes" in radeon_driver.c does is delete all
> modes since the timing info is technically not needed by them for DFP.
>
> That is just a pisser since it removes the completely valid mode I had
> placed into the XF86Config-4 for just that reason.
>
> So no great mystery but I just don't think they should do that when using
> fbdevhw.

So fix it and submit a patch. ;)


> That is only part of the problem, the other is that if you change the
> depth from what is used by the frame buffer it does mess up as others have
> reported.

I believe Ben's work on radeonfb should fix this.

We were talking about different resolutions, which probably breaks due
to the fbdev driver.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
