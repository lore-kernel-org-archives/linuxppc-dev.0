Return-Path: <hlrprasad@tataelxsi.co.in>
Received: from mail.tataelxsi.co.in (mail.tataelxsi.co.in [203.200.1.48])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(Client CN "myname.my.domain",
	Issuer "www.mirapoint.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EF54167B59
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Sep 2006 16:35:35 +1000 (EST)
From: Ram Prasad H L <hlrprasad@tataelxsi.co.in>
To: <linuxppc-embedded@ozlabs.org>
Subject: MPC5200B - FEC Error
Date: Tue, 5 Sep 2006 12:00:00 +0530
Message-ID: <000201c6d0b4$b6d08f50$4129320a@telxsi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Reply-To: Ram Prasad H L <hlrprasad@tataelxsi.co.in>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi all,
	this is Ramprasad, and we are using freescale's Lite5200B
using MPC5200B as core, for one of our applications.
The board is booted with u-boot-1.2.2 and linux kernel 2.4.25.

	I'm finding a very peculiar problem with the board when I
run my application which extensively uses the FEC for receiving
video and audio streams from network. The application runs fine for
some time say 2-3 hrs and suddenly i'm getting the following error
and the OS starts rebooting.

The error log looks somewhat like this:

NIP: C0124ECC XER: 00000000 LR: C0125028 SP: C01B6270 REGS: c01b61c0 TRAP:
0300    Not tainted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 000000F0, DSISR: 20000000
TASK = c01b4470[0] 'swapper' Last syscall: 120
last math c228a000 last altivec 00000000
GPR00: 000000F0 C01B6270 C01B4470 00001032 00001032 00000006 C0C11034
C3C61CC0
GPR08: 0000003F 00000000 C01CE9F8 C01CEAD0 00000002 1012A714 03FBA000
00000000
GPR16: 00000001 00000001 FFFFFFFF 007FFF00 00001032 C3F93000 C0210000
00000000
GPR24: C3C06012 00000045 C01E0000 C0BE1320 0000054E C01CE9E0 C01CEA08
C3CA9A20
Call backtrace:
C0125528 C011AF0C C0006CD8 C0006D98 C0005C40 C00072C8 C00072E4
C0003918 C01CF5B8 000035F0
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 <0>Rebooting in 180 seconds..<4>MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit
MPC5xxx_FEC_IEVENT_RFIFO_ERROR
mpc5xxx_fec_reinit


	Can anyone tell me what is the reason to face such
an error? and how can we avoid this error? any pointers
for overcoming it will be really helpfull as I'm stuck with
this problem since long time.

thanks and regards,

Ramprasad H L
