Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Reply-To: <fred@sc23.sc.mcel.mot.com>
From: "Liu Fred-a18596" <a18596@email.mot.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MSR__EE flag cause problem
Date: Sat, 7 Dec 2002 17:21:20 +0800
Message-ID: <003701c29dd2$01ddeed0$940879c8@sc.mcel.mot.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Greetings,

I am porting PPCBoot-1.1.5 to a PPC852 board. When PPCboot executes this
statement

       set_msr(get_msr() | MSR_EE);

in "interrupt_init()" which located at "cpu/mpc8xx/interrupts.c", the
console will display random characters.
But if I get rid of MSR_EE, that is "set_msr(get_msr());", then PPCBoot will
go on and display prompt.

I am a newbie for 8xx. What should I do?

BR,
Fred


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
