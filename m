Message-ID: <37D0F88E70D96C428C19EEB865701A3801E0D2C8@buda902a.siemens.hu>
From: =?iso-8859-1?Q?M=E9sz=E1ros_Lajos?= <ludwigm@siemens.com>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: MPC855T SMC1 2.4.22 Kernel Patch 
Date: Tue, 18 Nov 2003 07:20:27 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

> Console on SMC1 is standard. About 99% of all boards use it.

It is not standard.
It is
  a matter of habit | customary | practice | convention | usual.
  (Take Your pick; my native language is not english ... )

But, more importantly, shouldn'be standard. The processor has
2 SMCs and 4 SCCs for UART. The channel used (or usable)
depends on the existence of other communication channels.
For example, our (SIEMENS) last factory card uses SCC4 as
console and SMC2 as secondary UART. The ATM on FCC1-2
eats up all port pins dedicated to other UARTS.

Best Regards
    Ludwig

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
