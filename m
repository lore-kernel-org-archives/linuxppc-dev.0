Message-ID: <37E51662.8ACADA16@execpc.com>
Date: Sun, 19 Sep 1999 11:59:14 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Shaw Terwilliger <sterwill@io.nu>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: sound sleep
References: <19990919105401.015601@smtp.calvacom.fr> <37E50C29.CA2CE536@execpc.com> <19990919115435.A24214@io.nu>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Shaw Terwilliger wrote:
> Also, does anyone have a solution to my Lombard audio problem?
> After a snooze, it comes back up and my audio is gone.  The kernel
> driver seems to be there (mixers remember all previous levels and
> can set new ones), and user-space access to /dev/dsp and /dev/audio
> works, but nothing comes out of the speakers.

i have this problem ony my wallstreet/300 also.  I don't know of a fix yet.  A
temporary way around it would be to make a module of dmasound, and rmmod it
before sleeping, and insmodding it after, however it seems that this code is
also broken.  interrupt allocation.  will panic upon a 3rd insmod, or a cat of
/proc/interrupts while it is not installed.  If this were fixed, i'd think the
sleeping issue would be a snap.

-- 
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
