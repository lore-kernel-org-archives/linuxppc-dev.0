Date: Mon, 22 Sep 2003 10:13:26 -0500 (CDT)
From: Bret Indrelee <Bret.Indrelee@qlogic.com>
Reply-To: Bret Indrelee <Bret.Indrelee@qlogic.com>
To: Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Any restrictions on DMA address boundry?
Message-ID: <Pine.LNX.4.44.0309221006580.30267-100000@spider.ancor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Are there alignment restrictions on the address boundry your can
start a DMA with when using the pci_map_single() / pci_unmap_single()
calls?

For some reason, I thought they had to be cache line aligned, but when
I went back through the documentation I couldn't find any such
restriction.

-Bret

--
Bret Indrelee                 QLogic Corporation
Bret.Indrelee@qlogic.com      6321 Bury Drive, St 13, Eden Prairie, MN 55346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
