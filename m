Message-Id: <200006071954.VAA09159@denx.local.net>
To: "Brown, David (dbrown03)" <DBrown03@harris.com>
cc: Wolfgang Denk <wd@denx.de>,
        Raphael Bossek <raphael.bossek@solutions4linux.de>,
        Duncan Palmer <dunk@nsw.bigpond.net.au>,
        Magnus Damm <damm@kieraypc01.p.y.kie.era.ericsson.se>,
        linuxppc-dev@lists.linuxppc.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: My (per)version of 8xxrom 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 07 Jun 2000 11:56:12 EDT."
             <BE1C564723B3D21191FD0000F840E39801D81564@rfcmx2.rfc.comm.harris.com>
Date: Wed, 07 Jun 2000 21:54:32 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <BE1C564723B3D21191FD0000F840E39801D81564@rfcmx2.rfc.comm.harris.com> you wrote:
>
> I am using 8xxrom on one of our modem boards, to start Linux.
> I have made several little changes which seemed to be required.

Well, IMHO this code needs more than just a few little changes :-(

> Some of the changes are to support this specific board.
> Others are to allow booting zImage.initrd as an ELF image.
> Also I have added a "GO <address>" command to just jump to an address and
> go.
> Finally, I added an initial timeout to the serial input, so 8xxrom will run
> a default command if left unattended.

Thanks for that.

> I started with 8xxrom-0.3.0.  I heard about patches from Duncan, and I may
> have added them, but I'm not sure.  Since the compressed tar is small, the
> entire thing is attached.  I hope this is helpful for someone.

It is helpful to me. I will  try  to  merge  all  patches  that  I've
collected so far.

> Is there somewhere else I should deliver this?  As far as I know, the
> sourceforge home for 8xxrom hasn't really opened yet.

Yepp, Raphael has no time to care about this. I  met  him  yesterday,
and  we  agreed  to shift responsibilities. I received a message from
him today, that he assigned me and Magnus Damm (?) as  administrators
for the sourceforge tree.

That's correct, Raphael, isn't it?


I will try to coordinate changes a bit, and maybe start a re-write of
some parts of the code. I might have an engineer working on  this  by
mid-July to pick up what we have by then. My current intentions are:

* Make 8xxrom run on the TQM8xxL modules (99% of that are done)
* Add network boot using TFTP / BOOTP (Duncan Palmer is working on
  that, too)
* Add booting from PCMCIA / directly attached ATA disks (not working
  yet on the TQM8xxL)
* Add FLASH driver so that you can use the monitor to load an image
  over the network and write it to FLASH;
* Add some features needed for safe field upgradability (automatic
  selection between two or more boot images)

The list represents more or less the priorities as I see them at  the
moment.

Comments welcome, volunteers even more :-)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Generally speaking, there are other ways to accomplish whatever it is
that you think you need ...                               - Doug Gwyn

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
