Message-ID: <B171A2EF290DD4118E510010B5029006802220@feriex.feri.de>
From: "Halfmann, Klaus" <klaus.halfmann@feri.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: RE: Hang Mounting HFS CDROM with 2.4.3 final kernel
Date: Thu, 5 Apr 2001 07:54:53 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> gwiz% hpmount /dev/cdrom
> (null): /dev/cdrom: Neither Wrapper nor native HFS+ volume
> header found (Unknown error 4294967295)
>
> > Can you create an image from the disk (with dd) and does it show the
> > same problems ? (Id like to get that image, but I fear it may be to
> > large for a reasonable download/test. I only have an iBook :/ )
>
> Thanks for the tip.  Mounting the disk image works fine.  For the
> benefit of others that might encounter this problem and search the
> archives, the necessary commands are:
>
> 	dd if=/dev/cdrom of=cdrom.image
> 	mount -t hfs cdrom.image /mnt -o loop
>
Mmh, so reading via fopen() etc. on /dev/cdrom etc. works different than
on disk. This looks like a problem with the driver, so it may not be
the (direct) fault of the hfs kernel driver.

> > This is using the built-in DVD ROM drive on a dual G4 (but only
> > running a UP kernel).  I can mount an HFS disk without any problem.

Can someone comment on the status in this Driver. Is there something
new/different there ?

 	Klaus Halfmann
 	http://www.penguinppc.org/~hasi

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
