Date: Mon, 20 Sep 1999 09:26:38 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: miBoot 1.0d3
In-Reply-To: <19990919014557.023075@smtp.calvacom.fr>
Message-ID: <Pine.LNX.4.10.9909200924100.2752-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 19 Sep 1999, Benjamin Herrenschmidt wrote:
> Another issue is that I have currently no way to exit from miBoot. If I
> fail to boot Linux, I exit to the caller, the disk is ejected, but the
> machine doesn't try another disk to boot from. It may ne possible, it may
> not, I'll have to disassemble more of MacOS ROM in order to figure this
> out. I'd like to have a choice to boot MacOS, especially when miBoot is
> on a hard disk partition.  (I can still change the PRAM value and reboot).

That would indeed be nice. FYI, Amiga-Lilo can boot AmigaOS, since we
disasembled the ca. 20 bytes of code in the boot block.

Greetings,

			Geert (who actually doesn't care about  MacOS at all)

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint Stevens Woluwestraat 55
Phone +32-2-7248608 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
