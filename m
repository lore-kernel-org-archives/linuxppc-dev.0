Message-ID: <3ACCFFBB.58CC75D2@iiic.ethz.ch>
Date: Fri, 06 Apr 2001 01:28:59 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: "Jason E. Stewart" <jason@openinformatics.com>
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: External Monitor under Pismo
References: <20010404092143.EFE4C2F01B@apollo.valhalla.net> <3ACB537B.99B851B9@netfall.com> <87hf0433qs.fsf@amadeus.openinformatics.com> <3ACB6167.3B2E0242@iiic.ethz.ch> <878zlg31mw.fsf@amadeus.openinformatics.com> <3ACB9611.C95D16A2@iiic.ethz.ch> <87ae5w1ce3.fsf@amadeus.openinformatics.com> <3ACB9EB3.2661FFCE@iiic.ethz.ch> <87u242zz7y.fsf@amadeus.openinformatics.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Jason E. Stewart" wrote:

> I don't want to mess up my existing configuration so I only want to
> 'make install' if I can get it to happily install someplace other than
> /usr/X11R6/*

You'd have to set ProjectRoot in host.def before the build.


> Shouldn't I just need to install
>
> xc/programs/Xserver/hw/xfree86/drivers/ati/r128_drv.o
>
> into /usr/X11R6/lib/modules/drivers and restart the X server?

Bingo! Backup the original one though. ;)


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
