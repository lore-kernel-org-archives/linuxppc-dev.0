Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id D1B94B6F0C
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 17:59:58 +1000 (EST)
Received: by iwn1 with SMTP id 1so2009617iwn.15
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 00:59:57 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 29 Jun 2010 00:59:56 -0700
Message-ID: <AANLkTinA2ghLxBU41aFAsLM1oXQ8HMASx1eQMDVvi56n@mail.gmail.com>
Subject: machine check in kernel for a mpc870 board
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm porting a mpc870 board to the powerpc arch. The base is the
adder-875 board. My first try to boot the cuImage.my870 is
experiencing a machine check. And I have no clue where to look. Any
help?

=> bootm 1000000
## Booting image at 01000000 ...
   Image Name:   Linux-2.6.33.5
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    747319 Bytes = 729.8 kB
   Load Address: 00400000
   Entry Point:  004004d4
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Bus Fault @ 0x00404c40, fixup 0x00000000
Machine check in kernel mode.
Caused by (from msr): regs 07d1cb80 Unknown values in msr
NIP: 00404C40 XER: 00000000 LR: 00404C24 REGS: 07d1cb80 TRAP: 0200 DAR: 00000001
MSR: 00001002 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00

GPR00: 00404D50 07D1CC70 00000000 00000004 007FFF0C 00000001 0040AAB8 726F6F74
GPR08: 3D2F6465 0059D958 FF0009C0 0059DDDC FF003C00 1014BAC4 07FFF000 00000001
GPR16: 007FFF0D 004004D4 00000001 007FFF00 07FF9D78 FFFFFFFF 00000000 07D5D2A0
GPR24: 007FFEC0 00800000 00000000 00000000 00000000 0059D958 004129BC 00000000
Call backtrace:
machine check

Thanks alot,
-Shawn.
