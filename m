To: "XOL" <xol@mail.ru>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Re[2]: initrd for MPC860/862 with eldk2.1.10 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 08 Jun 2003 18:00:38 +0400."
             <E19P0is-000HpJ-00.xol-mail-ru@f15.mail.ru>
Date: Sun, 08 Jun 2003 22:00:54 +0200
Message-Id: <20030608200059.00D08C5FD7@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <E19P0is-000HpJ-00.xol-mail-ru@f15.mail.ru> you wrote:
> Thanks for your help.
> I still can't go on.
> This is my problem in details. Am I doing something wrong?
> My board is EP PPC862 64M Ram 64M Flash.
>
> I made following:
> cp /usr/local/eldk/ppc_8xx/images/ramdisk_image.gz arch/ppc/boot/images/ramdisk.image.gz
>
> make menuconfig , Eanbled ramdisk 4M
>  <*> RAM disk support
> (4096)   Default RAM disk size
>    [*]   Initial RAM disk (initrd) support
>
> make zImage.initrd

So far, this looks good to me.

> zsrec arch/ppc/boot/images/zImage.initrd.embedded > /tftpboot/zImage.xxx1 ### This will create S-Record image
>
> After it on PPC it looks like
>
> >t
> Load using tftp via Ethernet
> Enter server IP address <10.4.8.25> :

I cannot help with this part, though. We don't use the EP bootloader.
We use U-Boot on our boards, where things are different (simpler).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If the car industry behaved like the computer industry over the  last
30  years, a Rolls-Royce would cost $5, get 300 miles per gallon, and
blow up once a year killing all passengers inside.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
