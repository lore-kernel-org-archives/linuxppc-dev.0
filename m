Message-ID: <20030725075856.65997.qmail@web41811.mail.yahoo.com>
Date: Fri, 25 Jul 2003 00:58:56 -0700 (PDT)
From: Cedric Aubert <cedric_aubert@yahoo.fr>
Reply-To: cedric_aubert@yahoo.fr
Subject: 2.4.21 MPC8xx Ethernet Fix
To: LinuxPPC Embedded <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I have saw that in kernel 2.4.21 they are a fix for
the net driver of
mpc8xx.

Does Anyone known what this fix is ?

Should be may be useful to had it to the next ELDK ?


Cedric


Summary of changes from v2.4.21-rc2 to v2.4.21-rc3
============================================

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Fix 'make znetboot'.  From Cort Dougan
  o PPC32: Important fixes in the MPC8xx enet driver
  o PPC32: Allow for the RTC IRQ to be board-defined


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
