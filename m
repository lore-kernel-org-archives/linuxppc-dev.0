Content-Type: text/plain;
  charset="iso-8859-1"
From: Paul Ruhland <pruhland@microwavedata.com>
Reply-To: pruhland@microwavedata.com
To: kd@flaga.is
Subject: Re: cramfs root filesystem corruption
Date: Fri, 31 May 2002 10:23:16 -0400
References: <A60FFE6CA339C742BE11C311EA8BFF5401641E@mdsms2.inside.mdsroc.com>
In-Reply-To: <A60FFE6CA339C742BE11C311EA8BFF5401641E@mdsms2.inside.mdsroc.com>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <200205311023.16775.pruhland@microwavedata.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If it was mounted it certainly wouldn't qualify as 'inactive', at least by my
standards.  It is not mounted or being used in any way by the running system.


> -----Original Message-----
> From: Kári Davíðsson [mailto:kd@flaga.is]
> Sent: Friday, May 31, 2002 10:07 AM
> To: pruhland@microwavedata.com; wd@denx.de
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: RE: cramfs root filesystem corruption
>
>
> Inactive meaning "unmounted" or just not beeing used?
>
> K.D.
>
> > -----Original Message-----
> > From: Paul Ruhland [mailto:pruhland@microwavedata.com]
> > Sent: 31. maí 2002 14:04
> > To: wd@denx.de
> > Cc: linuxppc-embedded@lists.linuxppc.org
> > Subject: Re: cramfs root filesystem corruption
> >
> > 200205301450.50112.pruhland@microwavedata.com> you wrote:
> > >> The cramfs image is in flash, mounted as root via mtd blockdevice.
> > >> Typically the error occurs during flash reprogramming (
> >
> > using mtd char
> >
> > >> device '/dev/mtd0' ) ...during/after flash programming the cramfs
> > >> filesystem 'loses' information ( files disappear ).  The
> >
> > errors from syslog
> >
> > >> are 'error during decompression', typically the error
> >
> > numbers ( from
> >
> > >> 'linux/zlib_fs.h' ) are Z_BUF_ERROR, for the first error,
> >
> > and Z_DATA_ERROR
> >
> > >> for the rest.
> > >
> > > Ummm... can you please explain EXACTLY what you
> > > are doing? You have a
> > > cramfs in flash, mounted as root, and you are erasing and
> >
> > overwriting
> >
> > > the SAME cramfs partition WHILE RUNNING FROM IT?
> >
> > No, I have redundant cramfs images in flash.  I am erasing
> > and overwriting the
> > inactive image while the other, active image,  is mounted as root.
> >
> >


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
