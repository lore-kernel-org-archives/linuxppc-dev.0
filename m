Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <294FD9D3403A0340BDAC38E48DCEFFDCA729@RES-EXCH>
From: Lokesh Kumar <kumar.lokesh@wrx-us.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: cramfs mpc8xx 2.4.18
Date: Fri, 13 Feb 2004 13:32:34 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Gurus,

I have a custom board running 2.4.18 with initrd. Now, I want to make cramfs
as root filesystem. When I built cramfs support in the kernel and gave it
root=/dev/mtdblock1 (where my cramfs in correct endian order is stored on
flash) rootfstype=cramfs, the kernel hangs. MTD support is built in the
kernel. If I build cramfs as module, then boot my kernel with initrd (ext2)
and then mount it (on say /mnt), I can read cramfs correctly.

I also looked at rd.c file in drivers/block and noticed that this is does
not have cramfs initrd support. Do I need this? What am I doing wrong?
Please help

Lokesh Kumar


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
