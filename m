Message-Id: <v03130310b2f9566dc824@[38.11.199.159]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 2 Mar 1999 01:03:14 -0600
To: MkLinux Setup List <mklinux-setup@public.lists.apple.com>,
        Linux/mac68k List <linux-mac68k@baltimore.wwaves.com>,
        LinuxPPC Dev List <linuxppc-dev@lists.linuxppc.org>
From: "David D. Kilzer" <ddkilzer@earthlink.net>
Subject: ANNC: m68k-linux cross-development RPMS for ppc linux
Cc: Ryan Rasmussen <ryan.rasmussen@mankato.msus.edu>,
        Joe Pranevich <jpranevich@lycos.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've created RPMS of m68k-linux cross-development tools for ppc linux R4
systems (MkLinux and LinuxPPC).  You may download them from the following
FTP site.

ftp://ftp.mac.linux-m68k.org//pub/MacLinux/cross-compile/ppc/

The RPMs and SRPMs are listed below.

binutils-m68k-linux-2.9.1.0.4-1a.ppc.rpm   2203K
egcs-m68k-linux-1.1.1-1a.ppc.rpm           4312K
glibc-m68k-linux-2.0.4-1a.noarch.rpm       2081K

binutils-m68k-linux-2.9.1.0.4-1a.src.rpm   5641K
egcs-m68k-linux-1.1.1-1a.src.rpm          11330K
glibc-m68k-linux-2.0.4-1a.src.rpm          2934K

They were built to facilitate the Macintosh port of the Linux/m68k project,
but feel free to use them however you'd like.

NOTES
-----
  1. After installing glibc-m68k-linux-2.0.4-1a.noarch.rpm, I had to
     rename /usr/m68k-linux/lib/libc.so.6 to
     /usr/m68k-linux/lib/libc.so.6-m68k so that it wouldn't be used when
     I ran a dynamically linked PPC program.  I'm sure I'm doing
     something wrong in the RPM spec file, but I'm not sure what.  Any
     info would be appreciated.

  2. I had to create a patch for the egcs cross compiler to force it to
     use "m68k-linux-as" instead of "as" when doing compiles, otherwise
     I wasn't able to use both the native ppc egcs and the m68k-linux
     egcs at the same time (which is required when making m68k Linux
     kernels under MkLinux or LinuxPPC.  Comments on this patch would
     be appreciated.  I think there is a better way to do it.

This info may also be found on the following web page.

 http://www.mac.linux-m68k.org/docs/ppc-cross-dev-tools.html

Dave
--
David D. Kilzer
ddkilzer@earthlink.net



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
