Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C99BBA3.8090703@thales-bm.com>
Date: Thu, 21 Mar 2002 11:53:23 +0100
From: Julien Eyries <julien.eyries@thales-bm.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: MBX boot loader on a MPC8260 custom board 
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi all ,

we have here a custom MPC8260 board (4 Mo flash, 32 Mo SDRAM,200 Mhz
MPC8260) and we want to use the HardHat linux from Montavista.
we are also using BDI-2000 probe (from ABATRON) .

the kernel we have build is based on the ADS8260 board which is quite
similar to our board.

the boot-loader we use is the "mbx" boot loader which come with the
Linux kernel tree.

the problem i have is :
- we load the file "zvmlinux.mbx" using the BDI2000 probe
- we take control over the MPC8260 with "ppc_82xx-gdb zvmlinux.mbx" and
"target remote xx.xx.xx.xx:2001"
- we do some "stepi" and the code runs, entering function
"decompress_kernel", then "serial_init" .
- at some point in this function "serial_init" , the PC (program
counter) begins to count downwards !!! for exemple ( 0x400000 ...
0x3ffffc ... 0x3fff8 ...  )

another point is: when debugging C source code (in emacs + gdb),
we can see that the programms jumps from one point to another (some
times backward) , not following the logical flow of the C source code
.Is that normal ????

what could be the reason of such behaviour ???
does someone here have an idea for our problem ?????


any help is welcome,
greetings,



--
Julien Eyries
R&D engineer
Thales Broadcast & Multimedia (ex-thomcast)
email: julien.eyries@thales-bm.com
fax: 33(0) 1 34 90 31 10
tel: 33(0) 1 34 90 31 01


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
