Message-ID: <39679C6C.CC794B77@denise.shiny.it>
Date: Sat, 08 Jul 2000 17:26:04 -0400
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: Nelson Abramson <pogtal@erols.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: bG3+damaged CD=crash
References: <XFMail.000706092421.pochini@shiny.it> <396499F3.491EA41@erols.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > My blue-G3 hangs completely when I try to read a CDROM with some
> > errors. The whole system freezes and the only cure is reboot (no
> > logs, no errors, no panics, no oops). My older 7300 simply told
> > it couldn't read the disk. Is it a known bug ?
>
> Maybe it's a bad CD?

Yes, it IS bad.

> Chances are if it crashes one machine and another
> won't read it, that the CD-ROM itself is bad, not the reader....
> If you
> purchased the CD (as opposed to burning it yourself), get in contact with
> the LinuxPPC people and ask for an exchange...

Ehmm, no.  This CDROM is a backup copy of all junk I d/l from the net. It's
content is not important. What I mean is thet if I try to read a file Linux
creashes.

cp /mnt/cdrom/foobar.tgz /home/pochini/    ---> Linux hangs completely

Doing the same on the old 7300 w/ SCSI CD reader if tells me it can't read the
disk and continues working happily.

> > Perhaps I'll buy a SCSI CD, I hate IDE junk.
>
> Your 7300 (I think, and AppleSpec backs me up) has a SCSI CD-ROM, so it's
> probably not the drives.

The problem is the pmac IDE software driver. Trying to read the same CDROM om
my PC gives an error and does not crash.


Bye.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
