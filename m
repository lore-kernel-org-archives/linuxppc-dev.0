From: Michael Norton <mnorton@cisco.com>
Message-Id: <200010202217.PAA03521@cisco.com>
Subject: COPTS for Makefile LinuxPPC 2000
To: linuxppc-dev@lists.linuxppc.org
Date: Fri, 20 Oct 2000 15:17:26 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi,

I am trying to build the OpenGL Heretic game and there are compiler options in t
he Makefile for m68k but not for the PPC.

COPT.m68k = -m68020-60 -O2 -fomit-frame-pointer -D__BIG_ENDIAN__ -D__32BIT__ \
        -DHAVE_ALLOCA_H


was should this statement read if I am going to compile a PPC image on my G4?

thanks,

Mike


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
