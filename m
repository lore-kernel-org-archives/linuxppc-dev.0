MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: 405EP PCI performance
Date: Thu, 27 May 2004 18:46:36 +0200
Message-ID: <80908CC5B2C9DB47AAF8C77892FCB44315F79D@lion.vector.com.pl>
From: "Andriy Korud" <a.korud@vector.com.pl>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I've noticed that any PCI Ethernet card in 405EP Evaluation board has limited tx rate to 66Mbit/s. If there are more cards - I still have 66Mbit/s for all cards.
Rx rate is OK - 100Mbit.
This doesn't look like CPU problem because the same CPU easily transmit 100Mbit via OCP Ethernet.

Any ideas which could cause such problem?

thanks in advance,

Andriy Korud.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
