Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <001301c1791c$e28385c0$6b97143e@jocke>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Monta Vistas HHL 2.0 ppc-8xx_gcc(2.95.3) buggy?
Date: Thu, 29 Nov 2001 22:29:10 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there

I am trying to compile the latest(2.4.16) ppclinux_2_4 kernel
for our custom MPC860 board and it wont boot(I get a signal 11 Oops).

If I reduce gcc flag -O2 to -O1 I get as far as the first
call to printk() in emit_log_char() where it Oops(signal 11).
If I replace the printk.c file with the one found in MV HLL 2.0 kernel,
It will boot just fine.  Then I change -O1 back to -O2 and I get an Oops
again. This time halfway through the booting process.

I can run the MV 2.4.2 kernel without problems.

I am on  RH 7.1 with almost all updates applied. Also tried to
compile it on  RH 7.0 but got the same result(signal 11).

This looks to me like a compiler problem, has anyone else
had similar problems ?

Where can I find a "good" cross compiler for ppc 8xx which
will run on RH 7.1?

         Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
