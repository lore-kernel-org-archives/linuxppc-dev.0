Message-ID: <00a801c381e8$090f4fa0$0700a8c0@eurostudio.local>
Reply-To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
From: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: unhandled Intterrupt
Date: Tue, 23 Sep 2003 17:33:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I to all,

We are currently using a deamon to control some activities on a custom
ppc8260 board running on ELDK 2.0.2 environment. We are also able to start
and stop its fuctionality at run time by issuing start and stop (or restart)
command.
Sometime during a deamon restart We observed the message "unhandled
Interrupt 0, disabled". This message is issued by the
ppc_irq_dispath_handler routine located into arch/ppc/kernel/irq.c and
should be referred to an interrupt request without source (referring to
MPC8260 Power QuiccII user manual 4.2.4).

Anybody knowns why this happens? Who can generate this error?

Many thanks in advance

Gianfranco


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
