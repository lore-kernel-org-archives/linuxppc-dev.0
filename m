Subject: Re: X works somewhat on DFP with latest radeonfb.c
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	linuxppc-dev@lists.linuxppc.org, Daniel Berlin <dan@cgsoftware.com>,
	ghannon@cspi.com
In-Reply-To: <20011117160749.13478@smtp.wanadoo.fr>
References: <20011117154533.UWKB21717.tomts13-srv.bellnexxia.net@there>
	<20011117160749.13478@smtp.wanadoo.fr>
Content-Type: text/plain; charset=ISO-8859-1
Date: 18 Nov 2001 00:17:29 +0100
Message-Id: <1006039050.4572.2.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2001-11-17 at 17:07, Benjamin Herrenschmidt wrote:
>
> >Thought you might like to know.  I took a look at the XF410
> >radeon_driver.c and compared it to the latest versions of radeon_driver.c
> >in XFreee86 CVS HEAD and they are quite different.
> >
> >CVS HEAD has a *lot* more support for DFP but since I had the radeonfb
> >working on the DFP I thought what the hell, and started to try to use XF
> >4.1.0 radeon_driver.c with only a few small tweaks (ignoring all of the
> >Flat Panel code which is old and not-working in XF410) with the UseFBDev
> >Option so all the DFP register stuff is handled by the radeonfb.c driver.
> >
> >X actually starts up with depths of 8 and depths of 24 (32bpp), and works
> >but the colors are all wrong:  too many pinks in the 8 bit version and
> >seemingly random colors in the 24 depth.
> >
> >So I am going to try and play around with the pallette setting.
>
> Ask Ani for his patches. I think the engine must be properly configured
> for big endian.

With Option "UseFBDev", the framebuffer device is used for setting the
palette.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
