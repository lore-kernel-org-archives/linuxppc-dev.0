Message-ID: <000601c022d8$859bbb70$505bdda0@inu.se>
From: Björn Lundberg <bjorn.lundberg@inu.se>
To: "Prashant Patel" <pmpatel@trinetcommunication.com>,
        <linuxppc-embedded@lists.linuxppc.org>
References: <00a001c021ad$c9abeb40$4d1f76d8@kennedy>
Subject: Re:  USB Related Questions
Date: Wed, 20 Sep 2000 09:57:55 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The only published stuff concerning USB for 8xx (that I've seen so far) is at:

http://www.honeywell.se/inu/usb/

This is an alpha driver, but operational for our use which is ACM.
It's for 2.2.5 but works with 2.2.13 as well.

I've started to upgrade the driver for the new API (URB based) and should be able to release this by the end of Oct or begining of Nov.

There are some more efforts running in the same directions but as I don't have the time to go thru old mails to see how much of this info is confidential I let them respond on their own.

Enjoy
  Bjorn
----- Original Message -----
From: "Prashant Patel" <pmpatel@trinetcommunication.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Monday, September 18, 2000 10:19 PM
Subject: USB Related Questions


>
>  Hello Everyone
>       I am new to the usb devices. I want to use usb device available on the
>  TQM8xx board. Can anybody tell me that which latest linux kernel supports
>  the usb ?  And from where i can get this latest kernel image.
>      I want to connect IBM digital Camera to this usb. So while configuring
> the kernel for usb supports, which things do i need to take care?
>
> Thanks
> Prashant.
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
