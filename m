Message-ID: <39DDC5F7.5468358@rd.francetelecom.fr>
Date: Fri, 06 Oct 2000 14:30:47 +0200
From: FASSINO Jean-Philippe <jeanphilippe.fassino@rd.francetelecom.fr>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Problem in GMAC ?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I think there are a small probleme in gmac drivers.
The size of received packet is not substracted by
CRC length. You can see that with ethereal on all Linux machine.
Then minimum packet is 64, but it must be 60.
And you can see that all packet is 4 bytes too long.

Is it normal or not ???

Jean-Philippe

--
--------------------------------------------------------------------------
 Jean-Philippe FASSINO              France Telecom R&D : DTL/ASR
 Tel : 04 76 76 45 52
 mailto:jeanphilippe.fassino@rd.francetelecom.fr
--------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
