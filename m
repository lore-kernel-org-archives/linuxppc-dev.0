Date: Fri, 27 Aug 2004 11:31:06 +0200 (CEST)
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: linuxppc-embedded@lists.linuxppc.org
Subject: ushort fcc_fcce
Message-ID: <Pine.LNX.4.44.0408271130100.16734-100000@linpc003.aimsys.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,

Why is
include/asm-ppc/immap_8260.h:   ushort  fcc_fcce;

and not uint fcc_fcce, as e.g. the fcc event register
in hdlc mode uses 32 bits.

thanks,

Jaap-Jan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
