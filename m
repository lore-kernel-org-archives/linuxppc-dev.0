Date: Sun, 17 Oct 1999 16:16:06 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: need Open PIC infos
In-Reply-To: <19991016191421.027499@smtp.calvacom.fr>
Message-ID: <Pine.GSO.4.10.9910171614310.16259-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 16 Oct 1999, Benjamin Herrenschmidt wrote:
> However, the new Apple ASICs contains an Open PIC interrupt controller
> (advertised as beeing a "chrp,open-pic" controller). After looking at the
> various docs I have and a quick search on Altavista, I couldn't find any
> relevant documentation on the chip.
> There's already some OpenPIC support in the kernel, but I'll have to
> change it a little bit since, for example, Apple hardware is not a good
> place to search for a 8259 master ;)
> I'd like some docs in order to have better understanding of the chip.

The i8259 slaves are not mandatory in OpenPIC.

Do you have the OpenPIC docs? They are somewhere on the AMD website. If you
can't find them, please ask me, I have a copy on my docs CD-ROM, as usual :-)

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Phone +32-2-7248632 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
