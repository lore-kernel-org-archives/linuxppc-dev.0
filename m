MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: cramfs root filesystem corruption
Date: Fri, 31 May 2002 14:07:25 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E31937F6A@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: <pruhland@microwavedata.com>, <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Inactive meaning "unmounted" or just not beeing used?

K.D.

> -----Original Message-----
> From: Paul Ruhland [mailto:pruhland@microwavedata.com]
> Sent: 31. maí 2002 14:04
> To: wd@denx.de
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: cramfs root filesystem corruption
>
>
>
> 200205301450.50112.pruhland@microwavedata.com> you wrote:
> >> The cramfs image is in flash, mounted as root via mtd blockdevice.
> >> Typically the error occurs during flash reprogramming (
> using mtd char
> >> device '/dev/mtd0' ) ...during/after flash programming the cramfs
> >> filesystem 'loses' information ( files disappear ).  The
> errors from syslog
> >> are 'error during decompression', typically the error
> numbers ( from
> >> 'linux/zlib_fs.h' ) are Z_BUF_ERROR, for the first error,
> and Z_DATA_ERROR
> >> for the rest.
> >
> > Ummm... can you please explain EXACTLY what you
> > are doing? You have a
> > cramfs in flash, mounted as root, and you are erasing and
> overwriting
> > the SAME cramfs partition WHILE RUNNING FROM IT?
> >
>
> No, I have redundant cramfs images in flash.  I am erasing
> and overwriting the
> inactive image while the other, active image,  is mounted as root.
>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
