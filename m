Message-ID: <000601c33173$8610e4c0$11a2a2c8@scomguo>
From: "yong_guo" <yong_guo@scomcenter.com>
To: "Callebaut Benoit" <callebaut@mailandnews.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <3EEDFF92@mailandnews.com>
Subject: Re: RE :how to do:root filesystem on flash?
Date: Fri, 13 Jun 2003 14:17:42 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


----- Original Message -----
From: "Callebaut Benoit" <callebaut@mailandnews.com>
To: "linuxppc-embedded mailing list" <linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, June 12, 2003 5:33 PM
Subject: RE :how to do:root filesystem on flash?


>
> I,
> 1 : Create a cramfs filesystem with the right endianess from your nfs
> filesystem using mkcramfs.
> Burn it into the flash( at the start of the flash).
Is it must be burned from the start of the flash?  My u-boot bin code is
burned at the start of the flash.

>
> 2 : In your kernel config set the "root=" option to : "/dev/mtdblock0"
In my system, the flash is registered as /dev/flasha, should i pass the
parameter "root=/dev/flasha" to kernel?

> Enable Flash MTDBlock support and the right options like CFI,...
> Set up the start of the flash and its length
> Enable Cramfs in filesystem
> Disable NFS as root filesystem.
>
> Rebuild your kernel and flash it.
> Reboot the board en enjoy.
>
> PS : This question was already a 100 times answered. Search in the mailing
> list before asking such a question.
> Or maybe a better idea : One may build a FAQ or a list of Howtos on such
> common questions.
>
> Benoit Callebaut
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
