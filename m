Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20040701111230.27014.qmail@web12825.mail.yahoo.com>
Date: Thu, 1 Jul 2004 04:12:30 -0700 (PDT)
From: Alireza Sadri <arsadri@yahoo.ca>
Subject: Re: UPM driver of MPC8260 
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040630142618.01866C109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi , thanks for your attentins.

I am not an expert, but i know the meanings of
programming of the board , ppcboot(bootloader) ,
kernel , linux,  ELDK(I have compiled it for my
board), driver , service , and i am familiar with
MPC8260 as a microprocessor.I was working on hardware
of this board.
we made a copy , a customized copy.

now i am working on software ,
i am going to make my custom SBC8260 standalone , so i
need to replace the ppcboot of the board with a
bootable linux image. I want this linux to mount the
flash, and then i put my own final program on the
flash , and as a service, linux will run the program
on any reset.(now,it would be standalone)

so i cannot hold the ppcboot (u-boot) on the flash, i
need the changes in my linux image , or using a linux
driver.

Can you please guide me through this process?
If I have to replace ppcboot , how can have
bootloader?
(I know board needs bootloader anyway , but i don't
know what it is. is it ppcboot? or ELDK makes a
bootable linux?)

Any other point of view is really wellcome.

Best Regards.



Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
