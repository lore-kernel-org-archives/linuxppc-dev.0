Message-ID: <009601c45383$56803340$2700000a@jmartin>
From: "jmartin" <jmartin@prodys.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: consistent_alloc problem solved(it seems)
Date: Wed, 16 Jun 2004 11:21:42 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


looking platform file, modify PCI_ISA_MEM_ADDR to 0 and fec starts fine.
PCI_DRAM_OFFSET set to 0 too.

fec now starts fine. Why PCI_ISA_MEM_ADDR affect to consistent_alloc?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
