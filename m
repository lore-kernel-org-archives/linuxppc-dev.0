Date: Wed, 15 Mar 2000 10:00:02 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Michel Lanners <mlan@cpu.lu>
cc: mj@ucw.cz, bh40@calva.net, linux-fbdev@vuser.vu.union.edu,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [linux-fbdev] [PATCH 2.3.x] fbdev reversion
In-Reply-To: <200003142211.XAA00663@piglet.grunz.lu>
Message-ID: <Pine.GSO.4.10.10003150959000.20855-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 14 Mar 2000, Michel Lanners wrote:
> Flames, comments, cookies, ideas? Beer?

#define _IO_BASE       0

breaks CHRP and PReP boxes that use plain ISA drivers (inb() and friends).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
