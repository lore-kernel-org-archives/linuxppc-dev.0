Message-ID: <20021121022612.96391.qmail@web13402.mail.yahoo.com>
Date: Wed, 20 Nov 2002 18:26:12 -0800 (PST)
From: Norm Legare <normlegare@yahoo.com>
Subject: mkcramfs building
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I would like to create 2 cramfs filesystems on my flash so that I can
copy the kernel and the root filesystem on each, but I am having
trouble getting mkcramfs to run on my target.  I built it on the host
with the cross-compiler and when I ran it on the target, I got the
error:

"mkcramfs: error while loading shared libraries: libz.so.1: cannot load
shared object file: No such file or directory".

So I proceeded to statically link mkcramfs and libz.so.1.  The filesize
grew from 79169 to about 1,719,000 bytes.  I am using the SELF set of
tools and kernel from DENX and it contains a Ramdisk which seems to be
limited to about 2MB (I'm just speculating here), because when I ran
the mkcramfs utility (in its bloated size of 1.7MB), it responded with:
"No more room on device" (or something very similar).  I noticed that
the libz.so.1 is only about 65K and the mkcramfs without the library is
about 79K.

So, I ask, is it possible to increase the total number of bytes (from
files) that the root filesystem can contain or can I run the mkcramfs
utility without the library statically linked and somehow have the
library libz.so.1 linked at runtime?  Or is there something that I
missed altogether?

TIA,
Norm

Yahoo! Mail Plus – Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
