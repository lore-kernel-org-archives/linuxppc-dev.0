Date: Fri, 3 Mar 2000 10:40:03 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Reply-To: Geert Uytterhoeven <geert@linux-m68k.org>
To: Cort Dougan <cort@fsmlabs.com>
cc: Gary Thomas <gdt@linuxppc.org>, Paul Mackerras <paulus@linuxcare.com>,
        Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: insw/outsw in ide.h
In-Reply-To: <20000303023257.G8636@medea.fsmlabs.com>
Message-ID: <Pine.GSO.4.10.10003031038210.20923-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 3 Mar 2000, Cort Dougan wrote:
> I think the 850's need this.  I don't have one and haven't tested on one
> but I recall some IDE silliness was necessary.

BTW, I'm in favor of having ide_*()-ops for all accesses, cfr. my comments in
the sources. Then we can distinguish between I/O port and I/O memory acces on a
per-machine/architecture base.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
