Date: Thu, 7 Feb 2002 11:29:50 -0700 (MST)
From: Derrik Pates <dpates@dsdk12.net>
To: Ani Joshi <ajoshi@shell.unixbox.com>
Cc: Jeffery von Ronne <jronne@ics.uci.edu>,
	=?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>,
	Kaoru Fukui <k_fukui@highway.ne.jp>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: two aty128 frame buffers?
In-Reply-To: <Pine.BSF.4.44.0202062110280.82577-100000@shell.unixbox.com>
Message-ID: <Pine.LNX.4.43.0202071127340.16392-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 6 Feb 2002, Ani Joshi wrote:

> You can't use 2 cards which require ISA IO (vgaHW uses ISA IO on rage128)
> right now, because of the multiple busses on the G4 machines.  You can
> comment out all the vgaHW calls and that will probably work, but without
> doing that it will always crash on any ISA IO operation.  The reason is
> because your second bus's ISA IO isn't mapped.

The issue is the same with the G3 tower - the video card is by default in
the 32-bit, 66 MHz PCI slot, which is a logically separate bus from the
64-bit, 33 MHz bus that the other 3 slots are part of. What sort of mods
will it take to make that work, anyway?

I've discovered that putting both cards in bus 0 (64-bit, 33 MHz bus) gets
both the cards going, though - and well, that works for me...

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
