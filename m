Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Boot failure
Date: Tue, 30 Mar 2004 14:50:06 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DAA7@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
Can any body gove me some insight inot the following error?

When I try to boot a kernel based on 2.6.3, it crashes when starting
init:

Root is on /dev/hda3, and everything on thet filesystem is newly
recompiled (linuxfromscratch) using gcc-3.3.2

Same thing happens when I try the ELDK2.x and ELDK 3.0 filesystems with
a 2.6 kernel

This is on a MPC8266 cpu

I have tried the dynamic version (against glibc-2.3.3) an a static
version.
(the dump is from the static version)

EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem).
Freeing unused kernel memory: 252k init
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C00DDBA0 LR: C00DDCEC SP: C04B7DC0 REGS: c04b7d10 TRAP: 0301    Not
tainted

MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000004, DSISR: 20000000
TASK = cffeb9c0[1] 'init' Last syscall: 5
GPR00: 00000000 C04B7DC0 CFFEB9C0 CFD63400 00000001 00000000 CFD63558
CFFFD370
GPR08: 00000008 00000000 00000000 CFD63400 48000842
Call trace: [c00ddcec]  [c00e1b08]  [c00cfee4]  [c0052040]  [c00477d4]
[c0047668]  [c0047b2c]  [c000779c]
Kernel panic: Attempted to kill init!
 <0>Rebooting in 180 seconds..

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
