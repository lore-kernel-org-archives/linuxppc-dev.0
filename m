Message-ID: <38B277B0.CC72A996@cnet.francetelecom.fr>
Date: Tue, 22 Feb 2000 12:49:04 +0100
From: FASSINO Jean-Philippe <jeanphilippe.fassino@cnet.francetelecom.fr>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: eieio & ld_le, ld_be
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just a question about ld_le* and ld_be*.
This function do a io read and enforce in-order execution with eieio.

Does eieio is really necessary when load value from IO ??
Maybe some computer (SMP, pci, ...) require that !
But, i try ld_* without eieio on my computer (G4) and that work well.

JP

--
--------------------------------------------------------------------------
Jean-Philippe FASSINO  Tel :  04 76 76 45 52
CNET : DTL/ASR         mailto:jeanphilippe.fassino@cnet.francetelecom.fr
--------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
