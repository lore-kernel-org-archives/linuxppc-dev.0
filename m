Message-ID: <007301c231a5$497a1e60$0700a8c0@pc005>
Reply-To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
From: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: mpc8260 TDM I/O programming
Date: Mon, 22 Jul 2002 19:29:08 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm working with a board which is derived from EST SBC8260 with Linux
2.4.0-test2 where I'm trying to program the MCC in conjunction with TDM1C
and TDM1D.
On the same pins, can be configured both SCC3 and SCC4. For this reason I
have disabled the I/O programming which is performed into the module
arch/ppc/8260_io/uart.c.
Now, upgrading the kernel revision, by using the file uart.c of 2.4.18 I
have performed the same operation but I'm not able to load anymore the
related mcc driver (with "insmod" command).
Anybody can give me the some reference to understand what is changed?

Many thanks

Gianfranco Morandi


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
