Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20010330155106.63365.qmail@web9904.mail.yahoo.com>
Date: Fri, 30 Mar 2001 07:51:06 -0800 (PST)
From: Freddy Lugo <wilflugo@yahoo.com>
Subject: No ROM monitor - debugging problem
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


     Hi all,

     I want to port Linux to a target prototype board.
 The target system runs on a PPC 755 processor on a
custom os.  I want to port Linux to perform some
benchmark and to convince the management to support
the decision.  There is no ROM monitor on the target.
Right now we use SingleStep 7.5 debugger and download
the code from a HP probe into RAM and start running it
with the debugger at the and specific address.
     I heard that this debugger doesn't support MMU
and we are waiting for a bdi2000 we already ordered.
I just wanted to do something before the bdi2000
arrives.  I checked on the list and some time ago,
someone said that the 755 is not supported on ppcboot,
that is still true??.
     I compiled the kernel and downloaded using the
SingleStep.  It started running on
arch/ppc/boot/head.S but when it goes to
decompress_kernel the debugger doesn't know what to
do.  I also checked on the list and some debuggers
doesn't support linux sections organization and in
some cases the kernel image is not downloaded.  So I
think this was the problem.
     I also compiled the gdb debugger to trying to
simlate the kernel (I don't know if this could be done
with the kernel), but when the is supervisor level
instruction is executed gdb brings me a "priviledge
level exception".  Apprently gdb works with default
user mode.
    So the question is, is there any way I could start
debugging the kernel to start my porting before the
bdi2000 arrives?? If there is, There is any
documentation I could use about what things I should
worry about?? (I read the
http://penguinppc.org/usr/embedded/howto/PowerPC-Embedded-HOWTO.html
and it is not very useful without a ROM monitor).  Any
help?


Thanks in advance,

Freddy


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
