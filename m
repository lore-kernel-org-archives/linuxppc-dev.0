Message-ID: <20020625134347.87851.qmail@web21307.mail.yahoo.com>
Date: Tue, 25 Jun 2002 15:43:47 +0200 (CEST)
From: =?iso-8859-1?q?pepe=20potamo?= <termitaaa@yahoo.es>
Subject: Re: cramfs for root filesystem? 
To: termitaaa@yahoo.com
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20020625123534.97ECE10340@denx.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


good morning, i made a little patch of ide driver to
eject the card without do an cardctl eject. works
fine, and status error and driver not ready for
command message errors dissapear, irq is free
perfectly and all inode and buffers information is
removed.

Also, i made a patch for mtd with and interlaced of 4,
useful for the mbx860, and adaptable to other flash
memory interlaced system.

I modified ppcboot 1.1.4 and boot perfectly on a
mbx860 too.

bye.



_______________________________________________________________
Copa del Mundo de la FIFA 2002
El único lugar de Internet con vídeos de los 64 partidos.
¡Apúntante ya! en http://fifaworldcup.yahoo.com/fc/es/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
