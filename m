Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3FC24EB1.60106@gcctech.com>
Date: Mon, 24 Nov 2003 13:32:17 -0500
From: "Christopher R. Johnson" <cjohnson@gcctech.com>
Reply-To: cjohnson@gcctech.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Tools question
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is probably way too big a question to ask here, but I'm hoping
someone can help me.  I have inherited a gcc 2.95.3 cross development
tool chain, which has been working fine to build for my powerpc-linux
target machine.  I'm building the kernel and user programs fine.  I'm
beginning to find as I add things in that I'm missing libraries.  Today
its libresolv which I need for pump.  Some questions:

1. Do I really need to go back and build my own tool chain?  I've tried
grabbing 2.95.3 sources and building by running configure with
--target=powerpc-linux, but I get some missing include file errors
building libgcc2.a.  I'm on a 405GP (no fp).  Should I even bother doing
this?

2. On my intel development machine I see that libresolv.a comes from
glibc-devel-2.2.5-34.  I have gcc-2.96-110 for my compiler.  Should I go
find a version of glibc-devel that matches up with my existing 2.95.3
tools?  How will I know if its the right version?

3. Better yet, is there somewhere I can just obtain a reasonable tool
chain that's ready-built for my target machine?  Complete with libraries?

Sorry for the newbie type questions.  I have the "Using and Porting GNU
CC" book, but am finding it a little too Stallman-esque to follow.  Anyone?

Thanks!

Chris Johnson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
