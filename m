From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	Daniel Berlin <dan@cgsoftware.com>, <ghannon@cspi.com>
Subject: Re: X works somewhat on DFP with latest radeonfb.c
Date: Sat, 17 Nov 2001 17:07:49 +0100
Message-Id: <20011117160749.13478@smtp.wanadoo.fr>
In-Reply-To: <20011117154533.UWKB21717.tomts13-srv.bellnexxia.net@there>
References: <20011117154533.UWKB21717.tomts13-srv.bellnexxia.net@there>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Hi Ben,
>
>Thought you might like to know.  I took a look at the XF410
>radeon_driver.c and compared it to the latest versions of radeon_driver.c
>in XFreee86 CVS HEAD and they are quite different.
>
>CVS HEAD has a *lot* more support for DFP but since I had the radeonfb
>working on the DFP I thought what the hell, and started to try to use XF
>4.1.0 radeon_driver.c with only a few small tweaks (ignoring all of the
>Flat Panel code which is old and not-working in XF410) with the UseFBDev
>Option so all the DFP register stuff is handled by the radeonfb.c driver.
>
>X actually starts up with depths of 8 and depths of 24 (32bpp), and works
>but the colors are all wrong:  too many pinks in the 8 bit version and
>seemingly random colors in the 24 depth.
>
>So I am going to try and play around with the pallette setting.

Ask Ani for his patches. I think the engine must be properly configured
for big endian.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
