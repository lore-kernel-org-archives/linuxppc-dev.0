Date: Wed, 30 Jun 2004 15:42:08 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: looking for .config file for RPXlite board for 2.6 kernel
In-Reply-To: <Pine.LNX.4.60.0406301416270.511@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0406301535290.4861@localhost.localdomain>
References: <Pine.LNX.4.60.0406301107130.18110@localhost.localdomain>
 <20040630171458.GA15960@smtp.west.cox.net> <Pine.LNX.4.60.0406301326160.10682@localhost.localdomain>
 <Pine.LNX.4.60.0406301416270.511@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 30 Jun 2004, Robert P. J. Day wrote:

...
> RAMDISK: Compressed image found at block 0
> VFS: Mounted root (ext2 filesystem).
> Freeing unused kernel memory: 72k init
> Warning: unable to open an initial console.
> Kernel panic: Attempted to kill init!

never mind, bozo move on my part -- starting from the default
rpxlite_defconfig, i forgot to configure devfs back into the system.
yeah, that'll do it.  ack.

so i'm up and running.  a few glitches to take deal with, but i have a
shell, i have a root filesystem, i have networking, i still have to
beat up on busybox to start behaving:

# lsmod
lsmod: QM_MODULES: Function not implemented

but it's alive.  IT'S ALIVE!

# uname -a
Linux (none) 2.6.7 #19 Wed Jun 30 14:48:33 EDT 2004 ppc unknown

rday

p.s.  i guess i'll also want to look at replacing devfs with sysfs and
udev at some point.  ah, maybe later ...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
