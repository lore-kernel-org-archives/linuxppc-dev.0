Date: Wed, 25 Aug 2004 21:25:20 +0200 (MEST)
From: "Patrick Huesmann" <tricknology@gmx.de>
To: Scott Anderson <scott_anderson@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
References: <412CE415.6010201@mvista.com>
Subject: Re: ppc-linux still not booting on my virtexII board
Message-ID: <32289.1093461920@www26.gmx.net>
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

> You should probably invalidate the cache before you flush it.  There is
> code to do this for the ML300.  Search for "mfdccr" in:
>
>
http://ppc.bkbits.net:8080/linuxppc-2.4/anno/arch/ppc/boot/simple/embed_config.c@1.24?nav=index.html|src/|src/arch|src/arch/ppc|src/arch/ppc/boot|src/arch/ppc/boot/simple
>

Thanks.
After digging in the data sheets, I noticed that the address where the
access fails (0x000931c0) is a boundary between cache lines. Don't know if
that means something, though.

Regards,
Patrick





--
NEU: Bis zu 10 GB Speicher für e-mails & Dateien!
1 GB bereits bei GMX FreeMail http://www.gmx.net/de/go/mail


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
