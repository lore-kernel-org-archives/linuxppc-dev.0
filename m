From: Juergen Beisert <jbeisert@eurodsn.de>
Reply-To: jbeisert@eurodsn.de
To: Paul Miller <pmiller9@users.sourceforge.net>
Subject: Re: 405EP peripheral bus
Date: Thu, 20 Nov 2003 09:52:04 +0100
References: <200311191443.16246.pmiller9@users.sourceforge.net>
In-Reply-To: <200311191443.16246.pmiller9@users.sourceforge.net>
Cc: Embedded PPC <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311200952.04145.jbeisert@eurodsn.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Am Mittwoch, 19. November 2003 21:43 schrieb Paul Miller:

> and I changed B0CR to 0x0043a000 and I'm trying to use mmap like:

How many RAM is in your System? Less than 64MiB? Or more? Maybe there is an
overlapping?

JB


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
