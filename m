Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Ani Joshi <ajoshi@shell.unixbox.com>
Subject: Re: X works somewhat on DFP with latest radeonfb.c
Date: Sat, 17 Nov 2001 11:23:28 -0500
Cc: <linuxppc-dev@lists.linuxppc.org>
References: <20011117154533.UWKB21717.tomts13-srv.bellnexxia.net@there> <20011117160749.13478@smtp.wanadoo.fr>
In-Reply-To: <20011117160749.13478@smtp.wanadoo.fr>
MIME-Version: 1.0
Message-Id: <20011117162042.FDYX11528.tomts16-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ani,

Ben mentioned below that you might have some patches to handle BigEndian
issues for radeon.

Any help would be greatly appreciated.

Thanks,

Kevin


On November 17, 2001 11:07, Benjamin Herrenschmidt wrote:
> >Hi Ben,
> >
> >Thought you might like to know.  I took a look at the XF410
> >radeon_driver.c and compared it to the latest versions of
> > radeon_driver.c in XFreee86 CVS HEAD and they are quite different.
> >
> >CVS HEAD has a *lot* more support for DFP but since I had the radeonfb
> >working on the DFP I thought what the hell, and started to try to use
> > XF 4.1.0 radeon_driver.c with only a few small tweaks (ignoring all of
> > the Flat Panel code which is old and not-working in XF410) with the
> > UseFBDev Option so all the DFP register stuff is handled by the
> > radeonfb.c driver.
> >
> >X actually starts up with depths of 8 and depths of 24 (32bpp), and
> > works but the colors are all wrong:  too many pinks in the 8 bit
> > version and seemingly random colors in the 24 depth.
> >
> >So I am going to try and play around with the pallette setting.
>
> Ask Ani for his patches. I think the engine must be properly configured
> for big endian.
>
> Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
