Message-ID: <20030425101327.39490.qmail@web41801.mail.yahoo.com>
Date: Fri, 25 Apr 2003 03:13:27 -0700 (PDT)
From: Cedric Aubert <cedric_aubert@yahoo.fr>
Reply-To: cedric_aubert@yahoo.fr
Subject: Console problem with linuxppc_dev-2.4.20
To: LinuxPPC Embedded <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have succesfully boot linux on my custom board
(MPC860) with the Denx
2.4.4 linux kernel with U-Boot 0.3.0.
In fact I have porting U-Boot and succesfully boot
linux without any port of
it (just boot and have
stdin, stdout on SMC1, no ethernet, no SCC). I use
some configuration in the
Denx 2.4.4 linux kernel source.
It's the "SMC1 for console" option. The other choice
is to use "SMC2 for
console" option and it's disable.

In the linuxppc_dev-2.4 CVS tree, this option
disappear. In look in the
uart.c, and I saw that the
SMC1 for console wasn't mandatory because it's only
test the SMC2 for
console option and if it's
disable then it's use SMC1. So It's normal that this
option disappear
because it's never test.

But if I try to boot the linuxppc_dev-2.4 kernel
nothing happen. I can't
test if linux really boot
behind because my card it's dommage now so until it
will be repair ...

But I want to ask to the list if someone had this
problem before.

Thanks a lot

Cedric

---
AUBERT Cedric
SDEL Controle Commande
Service R&D
rue Nungesser & Coli
44860 St Aignan de Grand Lieu

Tel : +33 (0)2 40 84 50 00
Poste : 5109
Fax : +33 (0)2 40 84 51 10

E-mail : cedric_aubert@yahoo.fr
Web : http://www.controle-commande.sdel.fr


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
