Message-ID: <3ACB9611.C95D16A2@iiic.ethz.ch>
Date: Wed, 04 Apr 2001 23:45:53 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: "Jason E. Stewart" <jason@openinformatics.com>
Cc: Andrew Sharp <andy@netfall.com>, Iain Sandoe <iain@sandoe.co.uk>,
	Tuomas Kuosmanen <tigert@ximian.com>,
	debian-powerpc@lists.debian.org, stewart.sadler@roke.co.uk,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: External Monitor under Pismo
References: <20010404092143.EFE4C2F01B@apollo.valhalla.net> <3ACB537B.99B851B9@netfall.com> <87hf0433qs.fsf@amadeus.openinformatics.com> <3ACB6167.3B2E0242@iiic.ethz.ch> <878zlg31mw.fsf@amadeus.openinformatics.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Jason E. Stewart" wrote:

> > Does anyone know if the old "CRTOnly" option (which was always commented
> > out in the source) worked?
>
> It's been a few months since I built the code from scratch, and I
> never used that option. That seems like a place to start.
>
> Should I just use apt-get to grab the server source, or do I need Ani
> Joshi's tree especially?

Both should be more or less equivalent. The best would of course be to get it
from CVS.

> Where is the CRTOnly option located (saves me running a recursive find ...)

xc/programs/Xserver/hw/xfree86/drivers/ati/r128_driver.c


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
