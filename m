To: rekha gvv <rekhagvvc@yahoo.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Custom MPC823 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 22 Jul 2003 23:33:07 PDT."
             <20030723063307.34015.qmail@web8004.mail.in.yahoo.com>
Date: Wed, 23 Jul 2003 11:03:12 +0200
Message-Id: <20030723090317.C192EC6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

in message <20030723063307.34015.qmail@web8004.mail.in.yahoo.com> you wrote:
>
> I had been working on FADS860T evaluation board.
> Used PPCBOOT 1.1.6 as the Bootloader
> Used linux-2.4.4 as the kernel from denx site.
>
> Right now we have come out with our custom board which
> houses MPC823 ,SDRAM ,FLASH Video encoder(adv7176)and
> IDE interfaces.
>
> So i would like to get some suggestions as to which
> bootloader and linux kernel i can use so that it will
> support video drivers,i2c drivers ,ide drivers.

As you probably know the PPCBoot project has been  discuntinued,  and
all efforts are now put into the U-Boot successor project.

U-Boot has support for video on MPC823, for I2C, and for IDE.

Same for our kernel (module linux-2.4 in our CVS server); it includes video drivers for the MPC823, see:

	arch/ppc/8xx_io/lcdvideo.h
	arch/ppc/8xx_io/video823.c
	arch/ppc/8xx_io/video_ad7176.h
	arch/ppc/8xx_io/video_ad7177.h
	arch/ppc/8xx_io/video_ad7179.h

As you can see, the ad7176 encoder used in your project is supported,
to. And of course there are I2C and IDE drivers in this kernel, too.



Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The goal of science is to build better mousetraps. The goal of nature
is to build better mice.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
