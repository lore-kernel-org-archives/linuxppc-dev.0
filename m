Date: Thu, 7 Feb 2002 11:26:43 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Derrik Pates <dpates@dsdk12.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: two aty128 frame buffers?
In-Reply-To: <Pine.LNX.4.43.0202071127340.16392-100000@andromeda.dsdk12.net>
Message-ID: <Pine.BSF.4.44.0202071122270.40334-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 7 Feb 2002, Derrik Pates wrote:

> The issue is the same with the G3 tower - the video card is by default in
> the 32-bit, 66 MHz PCI slot, which is a logically separate bus from the
> 64-bit, 33 MHz bus that the other 3 slots are part of. What sort of mods
> will it take to make that work, anyway?

There is work now in X to get this working, it requires a layer of PCI
abstraction which is pretty raw at the moment.  Hopefully in a few months
something solid should come out.  However, since we're discussing Rage128
cards in Mac's here, it can be said that the vga IO that is being done is
totally unnecessary, as the Rage128 does not require a vga mode to be
saved or restored on Macs.  So totally disabling the vga IO if you are
just using those 2 cards on your machine can be a valid solution (for your
situation, obviously not an X solution).

> I've discovered that putting both cards in bus 0 (64-bit, 33 MHz bus) gets
> both the cards going, though - and well, that works for me...

Yes, unfortunately though people on AGP G4's tend to use an AGP and a PCI
card.  I suppose they could do what you are doing and use the bottom 2 (or
however it works on G4s) PCI cards if they have 2 PCI boards.


ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
