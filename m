Date: Wed, 20 Oct 1999 15:03:15 -0500
From: Grant Erickson <grant@lcse.umn.edu>
To: linuxppc-embedded@lists.linuxppc.org
cc: Daniel Nilsson <daniel.n.nilsson@home.se>,
        Adrian Cox <apc@agelectronics.co.uk>, Wolfgang Denk <wd@denx.de>
Subject: Re: Support for IBM CPUs?
In-Reply-To: <Pine.LNX.4.04.9910181824370.4550-100000@www.linuxppc.org>
Message-ID: <Pine.SGI.4.10.9910201456390.20307-100000@brule.lcse.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I just got the TiVo Linux source code.

I haven't had a chance to do much other than kick off the 'tar zxvf'
extraction process for the three sizable distributions. Nonetheless,
here's the included README file for more information until I can get
another status update out once I've had a look at things and diff'd their
2.1.24 kernel against a stock 2.1.24 and a 2.3.22 kernel.

-----

This directory contains three different archives - "commands",
"kernels", and "toolchain".  The archives are in GNU "tar" format, and
have been compressed using GNU Zip (.gz suffix) and BZIP2 (.bz2
suffix).  The .gz and .bz2 versions of each archive are identical
except for the compression format - you need only one version of each.

If you're reading this README from our FTP site, and don't want to
spend the time to download these archives via your Internet
connection, you can receive a copy of the software on CD-ROM if you
wish.  A nominal copying-and-distribution charge applies if you order
the CD-ROM. Please contact "webmaster@tivo.com" for information
if you're interested in order a CD-ROM copy of this software.

Please refer to the COPYING file in each directory for detailed
information on the license and distribution terms which apply to each
specific tool, utility, compiler, kernel, or whatever.  Most of this
software is under the GPL, while some of it (e.g. libraries) are under
the LGPL.

The "commands" archive contains the source code for all of the
GPL-licensed programs which are included in the TiVo Personal
Television System software.  These versions are current as of the
1.2.0 and 1.2.1 versions of the TiVo software.  

total 17
dr-xr-xr-x  10 dplatt   root         3072 Oct 14 10:56 bash-2.02/
dr-xr-xr-x   2 dplatt   root         2048 Oct 14 10:56 cpio-2.4.2/
dr-xr-xr-x  12 dplatt   root         1024 Oct 14 10:56 e2fsprogs-1.06/
dr-xr-xr-x   9 dplatt   root         1024 Oct 14 10:56 fileutils-3.16/
dr-xr-xr-x   8 dplatt   root         1024 Oct 14 10:57 grep/
dr-xr-xr-x  10 dplatt   root         1024 Oct 14 10:57 gzip-1.2.4/
dr-xr-xr-x  10 dplatt   root         1024 Oct 14 11:00 modutils-2.1.85/
dr-xr-xr-x   6 dplatt   root         1024 Oct 14 11:00 net-tools-1.432/
dr-xr-xr-x   5 dplatt   root         1024 Oct 14 11:00 procps-1.2.9/
dr-xr-xr-x   5 dplatt   root         1024 Oct 14 11:00 ps/
dr-xr-xr-x  11 dplatt   root         1024 Oct 14 11:01 sh-utils-1.16/
dr-xr-xr-x   3 dplatt   root         1024 Oct 14 11:01 sysklogd-1.3.26/
dr-xr-xr-x  10 dplatt   root         1024 Oct 14 11:01 textutils/
dr-xr-xr-x   2 dplatt   root         1024 Oct 14 11:01 tnlited/

The "kernels" archive contains the source code for the Linux kernel in
the TiVo Personal Television System software.  The "linuxdist-2.1.24"
source tree is configured for use on an Intel X86 development
platform.  The "linux-2.1" source tree is configured for use on the
PowerPC-based hardware system on which the TiVo software actually runs.

total 2
dr-xr-xr-x  15 dplatt   root         1024 Oct 14 10:58 linux-2.1/
dr-xr-xr-x  15 dplatt   root         1024 Oct 14 11:00 linuxdist-2.1.24/

The "toolchains" archive contains the source code for various GNU
software development tools and libraries used in the development of
the PowerPC-based TiVo software releases.  Although the compilers and
development utilities are not shipped with the TiVo-based receivers,
they are provided here as a courtesy to developers and other curious
individuals.

total 14
dr-xr-xr-x   3 dplatt   root         1024 Oct 14 11:01 binutils/
dr-xr-xr-x   3 dplatt   root         1024 Oct 14 11:03 gcc/
dr-xr-xr-x   5 dplatt   root         1024 Oct 14 11:09 gdb/
dr-xr-xr-x  59 dplatt   root         8192 Oct 14 11:13 libc/
dr-xr-xr-x   2 dplatt   root         1024 Oct 14 11:13 libc-ppc/
dr-xr-xr-x   2 dplatt   root         1024 Oct 14 11:13 tcdmem/
dr-xr-xr-x   2 dplatt   root         1024 Oct 14 11:13 xppcbt/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
