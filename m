Message-ID: <004001c4362d$82953020$0300a8c0@BIGSHOT>
Reply-To: "John Zhan" <zhanz@fel.com.cn>
From: "John Zhan" <zhanz@fel.com.cn>
To: "linuxppc-embedded@lists.linuxppc" <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8245:PCI unstable
Date: Mon, 10 May 2004 09:24:16 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,folks,
I am working on a custom board based on XPC8245LZU333B, 2 ethernet adapters (DP83816) were used on the PCI bus.
Of cause with Linux.
The 100base-tx of the board was connect to LAN and perform a data transfer . The transfer just like ping some host or pinged by some host.The transfer can keep for some time. But Linux maybe crash occasionally. the duration from the start of the transfer to the Linux crash maybe some dozens of minutes or hours.
My Linux port from mvista 2.4.26 sandpoint.
I noticed  that  XPC8245LZU333B's PCI host can't support  Type 2 Fast back-to-back transactions, but I am not sure if this cause the problem?
If the drivers should be updated to avoid PCI Fast back-to-back transactions in 8245 systems? If anything else should be taken into account to make the PCI stable?

Any clues are greatly appreciated.

Best Regards.
--
John.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
