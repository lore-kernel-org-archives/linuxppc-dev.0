From: Girard Guivel <gguevel@interfaceconcept.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MMU problems on MPC860P
Date: Thu, 28 Sep 2000 16:28:04 +0200
Message-ID: <000001c02958$65d9b040$2901a8c0@none>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I had problems to port linux2.2.14 on my own board.
I thaught it was because I use a MPC860P and not MPC860 or MPC860T.

My mistake was to map IMMR to 0x50000000.
IMMR must be mapped over 0x80000000 (like 0xFA200000)
because Linux uses 2Gb of virtual ram.

So linux2.2.14 works fine on a MPC860P.

Thanks to Dan for his help and ideas.


Gerard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
