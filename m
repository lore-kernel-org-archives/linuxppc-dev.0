Message-ID: <757A9CB222EBD5118D2300D0B7828DE10CAEF8C0@az33exm32.corp.mot.com>
From: Swarthout Edward L-SWARTHOU <SWARTHOU@freescale.com>
To: "'Cordes, Aaron M'" <aaron.m.cordes@lmco.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Linux 2.4.27-pre6-bk hangs on MPC8540 board
Date: Thu, 12 Aug 2004 15:14:47 -0700
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> We are bringing up an 8540-based board, and are getting hangs at
> random spots when booting Linux.  Sometimes the hangs occur while the

Indeed, classic memory corruption symptoms.

> Is there a way in Linux or the 8540 to prevent burst accesses,
> in order to test whether they are the problem?

Instead of trying to mask the problem by using crawl modes, I would suggest
proving that it is a DDR interface problem by enabling ECC (of course you
need to be able to plug in an ECC memory).  Most interface corruptions will
be detected by the ECC logic.

It is much easier to resolve board or DDR configuration issues when hardware clearly reports an ECC error instead of causing code to go wild.

u-boot supports enabling ECC, but it does not report its occurrence.

Ed dot Swarthout at Freescale dot com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
