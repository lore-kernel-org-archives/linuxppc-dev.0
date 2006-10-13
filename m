Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 866E5679E7
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Oct 2006 00:28:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6EED2.3AA503D3"
Subject: preempt crash in 2.6.18
Date: Fri, 13 Oct 2006 09:16:52 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B07B397@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6EED2.3AA503D3
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


This is from a Freescale 8265 running 2.6.18
Anyone have any idea what this is and how to fix it?

TIPC: Blocking bearer <eth:eth0>
huh, entered a0232b3c with preempt_count 00000102, exited with 00000203?
kernel BUG in __run_timers at kernel/timer.c:453!
Oops: Exception in kernel mode, sig: 5 [#1]
PREEMPT
NIP: A0024574 LR: A0024574 CTR: A0032104
REGS: a02cfd90 TRAP: 0700   Tainted: P       (2.6.18)
MSR: 00029032 <EE,ME,IR,DR>  CR: 44024024  XER: 00000000
TASK =3D a02900a8[0] 'swapper' THREAD: a02ce000
GPR00: A0024574 A02CFE40 A02900A8 0000004C A02F0E34 00004481 F4915203 =
00000000
GPR08: 00000008 00000203 DE53FE9C A02CE000 44024084 414404C0 0FFCE000 =
FFFFFFFF
GPR16: 00000000 0FFC8D68 007FFF00 0FF77600 00000002 00200040 00800000 =
007FFEA0
GPR24: 00000000 A02F0000 A0290000 A02F61C8 A02CFE50 00000102 A0232B3C =
A02CE000
NIP [A0024574] run_timer_softirq+0x12c/0x214
LR [A0024574] run_timer_softirq+0x12c/0x214
Call Trace:
[A02CFE40] [A0024574] run_timer_softirq+0x12c/0x214 (unreliable)
[A02CFE70] [A001F38C] __do_softirq+0x80/0xe4
[A02CFEA0] [A0009ACC] do_softirq+0x58/0x60
[A02CFEB0] [A001F450] irq_exit+0x60/0x80
[A02CFEC0] [A0009A28] do_IRQ+0x70/0xbc
[A02CFED0] [A00047B4] ret_from_except+0x0/0x14
[A02CFF90] [A000C9BC] cpu_idle+0xf8/0x108
[A02CFFB0] [A0003790] rest_init+0x4c/0x60
[A02CFFD0] [A02D06A4] start_kernel+0x1b8/0x1f4
[A02CFFF0] [000032C0] 0x32c0
Instruction dump:
7fa3eb78 7fc803a6 83bf000c 4e800021 80df000c 3c60a025 7f86e800 3863eaf4
7fc4f378 7fa5eb78 419e000c 4bff4dfd <0fe00000> 7c0000a6 5400045e =
7c000124
Kernel panic - not syncing: Aiee, killing interrupt handler!

------_=_NextPart_001_01C6EED2.3AA503D3
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7233.69">
<TITLE>preempt crash in 2.6.18</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>This is from a Freescale 8265 running 2.6.18<BR>
Anyone have any idea what this is and how to fix it?<BR>
<BR>
TIPC: Blocking bearer &lt;eth:eth0&gt;<BR>
huh, entered a0232b3c with preempt_count 00000102, exited with =
00000203?<BR>
kernel BUG in __run_timers at kernel/timer.c:453!<BR>
Oops: Exception in kernel mode, sig: 5 [#1]<BR>
PREEMPT<BR>
NIP: A0024574 LR: A0024574 CTR: A0032104<BR>
REGS: a02cfd90 TRAP: 0700&nbsp;&nbsp; Tainted: =
P&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (2.6.18)<BR>
MSR: 00029032 &lt;EE,ME,IR,DR&gt;&nbsp; CR: 44024024&nbsp; XER: =
00000000<BR>
TASK =3D a02900a8[0] 'swapper' THREAD: a02ce000<BR>
GPR00: A0024574 A02CFE40 A02900A8 0000004C A02F0E34 00004481 F4915203 =
00000000<BR>
GPR08: 00000008 00000203 DE53FE9C A02CE000 44024084 414404C0 0FFCE000 =
FFFFFFFF<BR>
GPR16: 00000000 0FFC8D68 007FFF00 0FF77600 00000002 00200040 00800000 =
007FFEA0<BR>
GPR24: 00000000 A02F0000 A0290000 A02F61C8 A02CFE50 00000102 A0232B3C =
A02CE000<BR>
NIP [A0024574] run_timer_softirq+0x12c/0x214<BR>
LR [A0024574] run_timer_softirq+0x12c/0x214<BR>
Call Trace:<BR>
[A02CFE40] [A0024574] run_timer_softirq+0x12c/0x214 (unreliable)<BR>
[A02CFE70] [A001F38C] __do_softirq+0x80/0xe4<BR>
[A02CFEA0] [A0009ACC] do_softirq+0x58/0x60<BR>
[A02CFEB0] [A001F450] irq_exit+0x60/0x80<BR>
[A02CFEC0] [A0009A28] do_IRQ+0x70/0xbc<BR>
[A02CFED0] [A00047B4] ret_from_except+0x0/0x14<BR>
[A02CFF90] [A000C9BC] cpu_idle+0xf8/0x108<BR>
[A02CFFB0] [A0003790] rest_init+0x4c/0x60<BR>
[A02CFFD0] [A02D06A4] start_kernel+0x1b8/0x1f4<BR>
[A02CFFF0] [000032C0] 0x32c0<BR>
Instruction dump:<BR>
7fa3eb78 7fc803a6 83bf000c 4e800021 80df000c 3c60a025 7f86e800 =
3863eaf4<BR>
7fc4f378 7fa5eb78 419e000c 4bff4dfd &lt;0fe00000&gt; 7c0000a6 5400045e =
7c000124<BR>
Kernel panic - not syncing: Aiee, killing interrupt handler!<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6EED2.3AA503D3--
