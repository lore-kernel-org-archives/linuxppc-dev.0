Message-ID: <399C396E.C72DFCA4@execpc.com>
Date: Thu, 17 Aug 2000 14:13:50 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Vladimir Simonov <sv@asplinux.ru>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Can't find nvtool?
References: <NEBBKFDEKEFCPABJIFOMKEEFDEAA.sv@sw.mipt.ru>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Vladimir Simonov wrote:
> Reference
>  poof-19991029.tar.gz on http://www.ping.de/sites/zagadka/poof/
>  is broken.
> Can somebody help me to find poof sources?
> Thanks in advance
> Vladimir Simonov

If i recall correctly, the reason that nvsetenv didnt work on newworld boxen was
because the partitions in nvram are mapped to different offsets than oldworld.
like the xpram and OF partitions.  BenH's kernel recognizes where they are
mapped, and i think there is even a way to find out where in userspace.
'pmac_xpram_read/write' maybe?

The kernel used to report where they were mapped (dmesg), but doesn't seem to
anymore.

Basically, I'm saying that nvsetenv could/should be modified to recognize which
kind of system its on, and act accordingly.  If nobody wants to do it, I suppose
I could.

i wonder if using devfs we could have an nvram directory with devs pertaining to
each nvram partition.  or is that done already?

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
