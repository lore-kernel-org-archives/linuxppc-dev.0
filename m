Message-ID: <397FE1BE.2416FE2@jvc.nl>
Date: Thu, 27 Jul 2000 09:16:16 +0200
From: Stephan Leemburg <sleemburg@jvc.nl>
Reply-To: sleemburg@jvc.nl
MIME-Version: 1.0
To: Joseph Garcia <jpgarcia@execpc.com>
CC: Stephan Leemburg <pmud-bugs@jvc.nl>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: powerbook hang from post-sleep cdrom access - fix
References: <397FE132.1690D2DD@execpc.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks!

I wil put the code also in pmud itself. This should in fact be done at
kernel level, so a patch will be needed for the current tree.

Joseph Garcia wrote:
>
> I think I have a fix to prevent a system hang when trying to access a cdrom
> after sleeping.  I have a small util "wakebay" that simply does a
> CDROM_MEDIA_CHANGED ioctl on a specified device.  I added a the line "wakebay
> /dev/hdc" to PMUD's wakeup script on my PDQ.  This seems to get the desired
> response from the drive, in that it locks the door and spins the disk when it
> should, and if its not there, mounted, or otherwise, does nothing.
>
> my code can be grabbed from http://www.execpc.com/~jpgarcia
>
> Can this be done automatically at the kernel level?
>
> Thanks.
>
> --
> Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
> CS Undergraduate                      Student Employee - Systems Programmer
> University of Wisconsin - Madison                            UW Lidar Group

--
Stephan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
