Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20010430211516.24155.qmail@web9901.mail.yahoo.com>
Date: Mon, 30 Apr 2001 14:15:16 -0700 (PDT)
From: Freddy Lugo <wilflugo@yahoo.com>
Subject: Image download problem with gdb and DBI
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

When I tried to download the kernel image it gives me
the "bad gzipped data" error, I know that this is
caused because the image is not there or the
bootloader has an invalid address.

When I perform a "load" on gdb the output is:

>Loading section .text, size 0x742c lma 0x800000
>Loading section .rodata, size 0x175c lma 0x807430
>Loading section .data, size 0x1b6c lma 0x809000
>Start address 0x800000 , load size 42740
>Transfer rate: 170960 bits/sec, 502 bytes/write.

So the image area is not downloaded, I am assuming
this is the cause of the error.

This are the steps I am executing:
- start gdb using arch/ppc/boot/zvmlinux
- set gdb to work with a remote target (bdi2000)
- load the program (produced the above messages)
- run the program

Other info:
custom board running on a MPC750

What I am doing wrong??

Does the image (vmlinux) should be downloaded apart
from the bootloader?  How I told gdb or bdi2000 to
download the image area?  Is there is a common recipe
for this procedure?

Thanks in advance,

Freddy Lugo


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
