From: "Oliver Fuchs" <olivers.lists@gmx.net>
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Date: Thu, 12 Aug 2004 16:29:45 +0200
MIME-Version: 1.0
Subject: MPC82xx enet on SCC3
Message-ID: <411B9AF9.12494.1DA4A94@localhost>
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

as far as I understand, my kernel (2.4.24 from ELDK3.0) is not
prepared for Ethernet on SCC3 of the MPC82xx.
It seems to be necessary to modify arch/ppc/8260_io/enet.c
Am I right?
Is there anyone who has done this already?

Thanks in advance,
Oliver

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
