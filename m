Message-Id: <200105111733.f4BHXW621338@stimpy.networkrobots.com>
Date: Fri, 11 May 2001 10:40:05 -0700
To: linuxppc-embedded@lists.linuxppc.org
From: Paul White <pwhite@networkrobots.com>
Subject: Starting Point...
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Quick queston for everyone (Okay, is there ever a "quick" question?)

I have a custom embedded board with a 7410 on it.  I already have a linux
image booting on it, however its a 2.4.0 based kernel (linuxppc_2_5 I
believe?) and I am having some problems with it, mostly in the loadable
module (vmalloc, specifically) area.  I would like to start with the latest
and greatest recommended PPC linux kernel (something based off of 2.4.3 or
later?).  I plan on porting my LSP to whatever new kernel I decide to use.

On this list, I've seen several trees mentioned, i.e. Montavista,
Bitkeeper, linux_2_4, linux_2_4_devel, etc..   Can anyone recommend which
one I should start with?  Also, it will be very important in my environment
that I keep up with the Linux kernel in general and don't fall back too far
behind.  Some main requirements are loadable modules, IDE/Compact Flash
support, etc..

Is it not a good idea to download the "latest" kernel from kernel.org and
just port my LSP into that version? (such as 2.4.5-preN trees), or are
there some major fixes/advancements in other Linux trees targeted for PPC?

Thanks for the help...

Paul

-------------------------------------------------------------
Network Robots, Inc.         /--\               Paul H. White
                           / ____ \
4695 Chabot Dr. #200      / ( oo ) \       Software Developer
Pleasanton, CA 94588     /   ----   \             Engineering
(925) 924-8600           \   ----   /          (925) 580-4883
                          \  V--V  /
                           \      /
                             \--/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
