Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3CA31782.8020301@thales-bm.com>
Date: Thu, 28 Mar 2002 14:15:46 +0100
From: Julien Eyries <julien.eyries@thales-bm.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: some question on root filesystems
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello,

here is my situation : i first intented to use NFS as the root
filesystem for our embedded MPC8260 linux but they may be some
hardware design error which stop us to use the intel LXT971A
ethernet controller we have on our custom board.

therefore, i have removed all the network interface in our kernel, and i
try now to use the flash memory (4MB) we have. my question is : what
kind of filesystem is typically used in this case : initrd, cramfs, romfs ?

it seems to me that initrd is a little bit different in the way the
kernel boot over it than the other fs (using /linuxrc , pivot_root and
so on ...), why ?

and for the cramfs and romfs filesystem, how does the sytem "guess" the
memory range where your filesystem lives in ?

can you give me some feedback on the choice you may have made ??

Greetings,


Julien Eyries.



--
Julien Eyries
R&D engineer
Thales Broadcast & Multimedia (ex-thomcast)
email: julien.eyries@thales-bm.com
fax: 33(0) 1 34 90 31 10
tel: 33(0) 1 34 90 31 01

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
