Message-Id: <v04003a19b7fbbcf4b374@[24.70.162.28]>
In-Reply-To: <20011022194702.1461@smtp.wanadoo.fr>
References: <v04003a15b7fa25b3e8f4@[24.70.162.28]>
 <v04003a15b7fa25b3e8f4@[24.70.162.28]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 23 Oct 2001 19:45:10 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	<linuxppc-dev@lists.linuxppc.org>
From: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>
Subject: Re: idebus=133 ?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 2:47 PM -0500 10/22/01, Benjamin Herrenschmidt wrote:
[...]
>Well. I don't even know if it's really a 66Mhz slot, or some kind of
>hacked 33Mhz with a doubled clock (I don't know if it really follow
>the PCI spec for 66Mhz). I heard noise when the machine was released
>about that slot not beeing completely standard.

Just for the sake of trivia, I pulled up apple's docs on the B&W G3, and it
had this to say about the slot:


>The primary PCI bus includes slot 1, which accommodates only 32-bit 66 MHz
>+3.3 V PCI cards. Slot 1 conforms to the PCI V2.1 specification with the
>exception that its clock speed is fixed at 66 MHz so it does not accept
>33 MHz cards.
>
>The Power Macintosh G3 computer is always configured with an Apple 2D/3D
>accelerated graphics card installed in slot 1, so that slot is not
>available for PCI card expansion unless the card is removed. Slot 1 is
>keyed for 3.3V only operation, so older 5V cards cannot be installed in
>that slot.


So the fuss was likely about the different keying for the 3.3v cards (this
is also an issue in some SGI x86 machines), and the 66MHz-only restriction
(most 66MHz slots I've seen will automatically go down to 33MHz when you
insert an older card).

3.3v/universal cards seem to be becoming more widespread recently, though
66MHz cards seem to still be thin on the ground, or not labled very
obviously for me to notice them.


Seems kinda silly the way everyone's talking nowadays about PCI-X and
whatnot when you can't even get 64/66 PCI slots on anything sub-$15k, and
even 64/33 is a rarity outside macs and servers. Ah well.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
