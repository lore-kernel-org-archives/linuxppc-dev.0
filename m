Message-ID: <397FEEE5.265963BF@execpc.com>
Date: Thu, 27 Jul 2000 03:12:21 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: sleemburg@jvc.nl
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: powerbook hang from post-sleep cdrom access - fix
References: <397FE132.1690D2DD@execpc.com> <397FE1BE.2416FE2@jvc.nl>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Stephan Leemburg wrote:
> I wil put the code also in pmud itself. This should in fact be done at
> kernel level, so a patch will be needed for the current tree.

So would this always be done on wake to hdc and hde?  I read Pismos, and maybe
iBooks, have their drives at hde.  I'm not sure if they are afflicted by this
problem.

might also need to consider ide-floppy drives, like ls-120 and zip.  I don't
have one myself, so I don't know if these need it either.  They dont have much
for ioctls, just eject.  If they have this problem, an ioctl to
idefloppy_media_change may be needed.

I'm not concerned about it, but might genuine floppies have the hang problem
too?

I assume a bay hard drive would error/exit without a problem because they can't
change.

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
