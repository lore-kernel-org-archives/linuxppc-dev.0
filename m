Return-Path: <Agostino.Sette@technolabs.it>
Received: from aquib01a.technolabs.priv (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id B228967B46
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Jun 2006 20:13:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: MPC852T help me for: Oops: kernel access of bad area, sig: 11
Date: Wed, 28 Jun 2006 12:01:14 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E2AADA9@aquib01a>
From: "SETTE AGOSTINO - technolabs" <Agostino.Sette@technolabs.it>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear,

Here is my problem,

Our environment is:

OS:       Linux-2.4.20
platform: MPC852T

Oops: kernel access of bad area, sig: 11
NIP: C000D440 XER: 00000000 LR: C00BB040 SP: C06BDE50 REGS: c06bdda0
TRAP: 0300    Tainted: P
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 0000205D, DSISR: 000000E4
TASK =3D c06bc000[181] 'L5420' Last syscall: 78
last math 00000000 last altivec 00000000
GPR00: 00000000 C06BDE50 C06BC000 C0D074E0 00002059 0000003C C0D074DC
00000007
GPR08: 00000001 0000003C 00000000 C0D07520 82004084 101B3AF8 3052816C
C3120000
GPR16: C311CB04 C311C8D8 C311C754 C0170000 C3120000 C311CB30 00000001
C0169DA0
GPR24: F0000E00 0000205D C0F58400 0000003C 00000040 C2080100 C0F58200
C0F50360
Call backtrace:
C00BAF8C C00BABC8 C0005848 C3119448 C3119918 C00047A8 100D8AC0
100D6718 100C370C 100674AC 100639E4 1005ED18 10042638 10010E28
1003AC34 1000DA34 100361EC 0FED34A4 0FED32D0 0FFCFEE4 0FD5F590
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 <0>Rebooting in 180 seconds..

How to debug and correct it? Plese help me!

Thanks a lot!
-------------------------------------------

Best Regards

Agostino Sette
