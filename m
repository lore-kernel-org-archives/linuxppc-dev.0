Message-ID: <619D608DD3F0D311882C009027732E1A8361F8@ntserver.act.domain>
From: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
To: "PPC-Linux list (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Linux and two PCI busses
Date: Mon, 27 Aug 2001 11:10:55 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all

We have a design where MPC8260 has two independent PCI busses.  We use
Tundra PowerSpan device to provide two PCI busses.
Linux only supports single PCI bus.

Anyone tried to modify Linux to have support for multiple PCI busses? I mean
two independent busses, not a PCI bus and another PCI bus behind a bridge.

Thanks,
Rudolf


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
