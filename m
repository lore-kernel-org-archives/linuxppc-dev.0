Message-ID: <001f01c0b25d$d1d6c5b0$029515d1@skelmir>
From: skelmir@skelmir.com (Mimir Reynisson)
To: "John F. Davis" <davis@skink.net>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <20010321175758.A7228@skink.net>
Subject: Re: ramdisk size using montevista
Date: Wed, 21 Mar 2001 18:22:38 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In addition to strip you'll probably want to rebuild glibc as well without
debug info and optimize for size (not that gcc does all that much with
-Os but it'll certainly be better than -g).

----- Original Message -----
From: "John F. Davis" <davis@skink.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, March 21, 2001 5:57 PM
Subject: ramdisk size using montevista


>
> Hello
>
> I am trying to boot hardhat linux with a small ram disk.  However, libc is
more
> than 4 megs by itself.  Is there something obvious I can do/read?  I tried
using
> busybox, but that only makes the bin directory small.  I don't really know
> what I should do about the /lib directory.
>
> John
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
