Message-ID: <010e01bfff18$2fcc9d60$0401a8c0@hoangmobile>
From: "Nguyen Xuan Hoang" <hoang_nguyen@smartstors.com>
To: "Matthew Locke" <mlocke@mvista.com>
CC: <linuxppc-embedded@lists.linuxppc.org>,
        "jari" <thanh_nguyen@smartstors.com>
References: <380658298.965240776157.JavaMail.root@web621-wrb.mail.com> <39888816.AEA4C307@mvista.com> <001101bffd79$167e2860$0401a8c0@hoangmobile> <005601bffe7f$9acd22e0$0401a8c0@hoangmobile> <398B0C1F.DCB6641A@mvista.com>
Subject: Re: Usb slave API
Date: Sat, 5 Aug 2000 13:03:02 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you very much for your reply.

>
> > > From my understanding the usb slave driver (not host) was done for
MPC823
> > > and MPC850, but I can't  find where it is
>
> As Dan said, hopefully the annoucement will happen soon.

I am glad to know that.

>
> > >  nor what is the API for it (In
> > > official linux kernel there's a API  for USB host function). Am I
right or
> > > too stupid?  I hope some people in this maillist can give a point.
>
> Which kernel are you looking in?  USB support in the 2.2 kernel isn't
> very stable. 2.4 has a very nice implementation and I think you can find
> backports to the 2.2.  However backports are not always stable.

I thought MVista is going to release 2.2.14 with USB support so I plan to
use 2.2.14 with backport

> Basically the kernel provides slave (peripheral) drivers for the basic
> peripheral classes, printer, scanner, mouse, keyboard, etc.  look in
> drivers/usb for those files to use as examples.
>

If I am not wrong, these are the driver in host mode. I am looking for tha
API when MPC823 configure as usb slave, which can connect to PC (like Kodak
DC290 using MPC823).

Is the Slave and Host API the same? I am very supprised  if that' correct.

>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
