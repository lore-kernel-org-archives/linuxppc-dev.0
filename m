Message-ID: <39659EB2.D4C095A6@amulet.co.jp>
Date: Fri, 07 Jul 2000 18:11:14 +0900
From: Hollis Blanchard <hollis@amulet.co.jp>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: linuxppc-dev@lists.linuxppc.org, Ethan Benson <erbenson@alaska.net>
Subject: Re: Drive Setup (was Multi-boot)
References: <200007070846.JAA05142@hyperion.valhalla.net>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
>
> On Fri, Jul 7, 2000 Ethan Benson  wrote:
[snip]
> >
> > every time i tested it the following occured:
> >
> > * drive setup crashed
> > * the partition tables were corrupt.
> >
> > its just good policy to use the native fdisk to create an OS'es
> > partitions, on intel we must use DOS fdisk to create DOS/Win*
> > partitions and linux fdisk for linux partitions, same with OpenBSD,
> > FreeBSD etc.  powerpc is no different.

[snip]

>
> Someone should tell Apple if there's a problem - they seem to be willing to
> support (at least) the existence of Linux & other OSs - unlike certain other
> companie$

I have never had Drive Setup crash on me, not even once. To try to
settle this question (not about stability, but about whether it produces
Linux-acceptable partition maps), I've just used Drive Setup's
unmodified "Preferred LinuxPPC" setting to partition a disk. The Mac OS
is currently installing, and I expect no problems when I install Linux
in 5 minutes.

The only complaint I have with Drive Setup is that it insists on erasing
all partitions on the drive any time you want to make partition changes.
Even newbies wondrously appreciating the beautiful Mac OS widgets in
their partitioning utility will not want to reformat their entire hard
disk.

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
