Message-ID: <019701c21d2c$edde98b0$3c0fa8c0@amitesting>
From: "Michael Meriin" <Michael@KSWaves.com>
To: "Chuck Partridge" <Chuck_Partridge@amx.com>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <sd199301.035@mx.amx.com>
Subject: Re: AMD Flash Interface for updating boot flash
Date: Wed, 26 Jun 2002 18:17:12 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Just define your flash as a MTD device and then, from user space use dd
command to copy your bootloader to flash:

dd if=bootloader of=/dev/mtdblock0

Best Regards,
                     Michael Meriin


----- Original Message -----
From: "Chuck Partridge" <Chuck_Partridge@amx.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, June 26, 2002 17:09
Subject: AMD Flash Interface for updating boot flash


>
> Hello all,
>
> I have been searching the archives and I am a bit confused, so bear with
me if this is too simple a question.
>
> I need to provide a way to update my boot flash from user space.
> Our user application will download an boot flash image and save it (to a
file or a buffer), we must then write the flash.
> I have seen references in the archives to Denx's drivers/char/amd_flash.c
and to MTD drivers, or I can
> implement my own driver, but I'm not sure of the best (i.e. easiest and
cleanest) way.
>
> I don't need to put a file system on the flash.  All it does is hold the
PPCBoot image.  The flash part is an AMD
> 29LV004B and is setup for 8 bit interface.  I am running a 2.4.17 kernel
on an 8245.
>
> Any suggestions?
>
> Thanks,
>
> Chuck
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
