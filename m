Message-ID: <20020821003010.49406.qmail@web40209.mail.yahoo.com>
Date: Tue, 20 Aug 2002 17:30:10 -0700 (PDT)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: 4xx ethernet and power management
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The new power management code is killing the 405GP
on-chip ethernet (no interrupts, no phy
communications, no packets).

If I comment out the body of ppc4xx_pm_init() in
ppc4xx_pm.c, ethernet works again.

I'm using the 2.4.19 kernel from
bk://ppc.bkbits.net/linuxppc_2_4_devel (CS 1.1114).

Armin, any comments?

Regards,
Brian Kuschak


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
