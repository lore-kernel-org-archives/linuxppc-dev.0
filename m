To: pruhland@microwavedata.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: cramfs root filesystem corruption 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 30 May 2002 14:50:50 EDT."
             <200205301450.50112.pruhland@microwavedata.com>
Date: Fri, 31 May 2002 08:44:08 +0200
Message-Id: <20020531064413.B2AC0102F2@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200205301450.50112.pruhland@microwavedata.com> you wrote:
>
> The cramfs image is in flash, mounted as root via mtd blockdevice.
>
> Typically the error occurs during flash reprogramming ( using mtd char device
> '/dev/mtd0' ) ...during/after flash programming the cramfs filesystem 'loses'
> information ( files disappear ).  The errors from syslog are 'error during
> decompression', typically the error numbers ( from 'linux/zlib_fs.h' ) are
> Z_BUF_ERROR, for the first error,  and Z_DATA_ERROR for the rest.  I've got

Ummm... can you please explain EXACTLY what you are doing? You have a
cramfs in flash, mounted as root, and you are erasing and overwriting
the SAME cramfs partition WHILE RUNNING FROM IT?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Wisdom is one of the few things that looks bigger the further away it
is.                               - Terry Pratchett, _Witches Abroad_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
