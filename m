From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: debugging using BDI2000 on MPC860
Date: Mon, 16 Jun 2003 12:56:23 +0200
Message-ID: <FCEAKDJJAPHPLJFINDAJAEKBDCAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I want to use our BDI2000 to debug my MPC860 board. Unfortunately it always stops with a machine check interrupt at 0x00000100.
Flashing works fine.
Our flash is at 0xff000000, IMMR at f0000000...

Any ideas? How do I define the boot address in MPC860 config files.

Thanks, Stephan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
