Message-ID: <001601c0cbf5$985a88b0$9e648a89@cern.ch>
From: "Shoudong Xu" <Shoudong.Xu@cern.ch>
To: <Brian.Dominy@radisys.com>, <Stefan.Balcerczak@marconi.com>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <OF47B371D7.E5F86146-ON85256A37.00439441@radisys.com>
Subject: Re: unable to mount root fs on 01:00
Date: Mon, 23 Apr 2001 15:02:04 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mr.Brian,

Why choose loopback drivers support ? It is very strange, Could you give a simple explain?

I think just need to select both CONFIG_BLK_DEV_RAM and CONFIG_BLK_DEV_INITRD to build zImage.initrd.

Best Regards,

Shoudong Xu



----- Original Message -----
From: <Brian.Dominy@radisys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: "Stefan Balcerczak" <Stefan.Balcerczak@marconi.com>
Sent: Monday, April 23, 2001 2:21 PM
Subject: Re: unable to mount root fs on 01:00


>
> Stefan,
>
> Check to make sure you have loopback driver support compiled into your
> kernel.  You'll need that in order to mount a ramdisk.
>
> Regards,
> Brian Dominy
>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
