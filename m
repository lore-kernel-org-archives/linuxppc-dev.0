Subject: powerpc cross tools question
Date: Mon, 25 Mar 2002 11:34:29 -0800
Message-ID: <668950F487446B4FB0CEAE9760FD2D62124F02@taurus.primary.local>
From: "Keith Outwater" <Keith_Outwater@mvis.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings all -
I built the powerpc-linux cross toolset from source using the
cross-compiling mini-howto on www.penguinppc.org.  I am running x86
linux (RH 7.2).

I followed the mini-howto to the letter, but I have two problems:
1. I must manually edit /usr/local/powerpc-linux/lib/libc.so to change
the paths from /lib/... to /usr/local/powerpc-linux/lib...

2. When I compile applications, certain #defines are missing such as
PATH_MAX.  It appears that /usr/local/powerpc-linux/include is not in
the compilers default search path (manually adding it allows the
application to compile successfully).

Has anyone used the mini-howto to build the cross tool chain?  Any
pointers?

Thanks!

Keith Outwater
Sr. Staff Engineer
Microvision, Inc.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
