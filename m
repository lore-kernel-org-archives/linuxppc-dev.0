To: Alireza Sadri <arsadri@yahoo.ca>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: UPM driver of MPC8260 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 01 Jul 2004 04:12:30 PDT."
             <20040701111230.27014.qmail@web12825.mail.yahoo.com>
Date: Thu, 01 Jul 2004 14:18:00 +0200
Message-Id: <20040701121805.E8164C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040701111230.27014.qmail@web12825.mail.yahoo.com> you wrote:
>
> i am going to make my custom SBC8260 standalone , so i
> need to replace the ppcboot of the board with a
> bootable linux image. I want this linux to mount the

No, this makes no sense. leave the PPCBoot as is, and use it to  boot
Linux.

> flash, and then i put my own final program on the
> flash , and as a service, linux will run the program
> on any reset.(now,it would be standalone)

Yes, booted by PPCBoot from flash.

> so i cannot hold the ppcboot (u-boot) on the flash, i
> need the changes in my linux image , or using a linux
> driver.

You will always need a boot loader to initialize the  hardware.  This
is what PPCBoot is doing for you. Only then you can start Linux.

> (I know board needs bootloader anyway , but i don't
> know what it is. is it ppcboot? or ELDK makes a
> bootable linux?)

Yes, PPCBoot is the boot loader. Do NOT replace it, just use it.

> Any other point of view is really wellcome.

Did you read the DULG? See http://www.denx.de/twiki/bin/view/DULG/Manual

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Lack of skill dictates economy of style.                - Joey Ramone

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
