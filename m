Message-ID: <67505026E29DD311A9AA00508B7315F350A734@EXCHANGE>
From: Julia Elbert <jelbert@enerdyne.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: flash writing with Linux
Date: Mon, 19 Mar 2001 09:45:10 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Is there a working version of mtd for ppc? I was working on it a while back,
was able to access the chip after memory mapping, but was unable to reliably
partition and mount the /dev/nftla. I think it was a problem on the reads
with inb and outb. I use the 860T from Embedded Planet.

Thanks,
--Julia

		-----Original Message-----
		From:	Kári Davíðsson [mailto:karid@flaga.is]
		Sent:	Monday, March 19, 2001 9:31 AM
		To:	linuxppc-embedded
		Subject:	RE: flash writing with Linux


		> -----Original Message-----
		> From: Matthias Fuchs
[mailto:matthias.fuchs@esd-electronics.com]
		> Sent: 19. mars 2001 17:16
		> To: Subodh Nijsure; linuxppc-embedded
		> Subject: Re: flash writing with Linux
		>
		>
		>
		> Hi Subodh,
		>
		> Subodh Nijsure wrote:
		> >
		> > Perhaps you can take a look at mtd and use that to
manage
		> your flash.
		> > With mtd you can partition your flash to different
devices
		> and erase them
		> > selectively.
		> What is mtd ? Never heard of before !

		It is flash abstracation layer (driver), and is now part of
the
		official linux 2.4.x kernels from Linus.
		http://www.mtd-infradead.org

		> >
		> > Once you have your flash partitioned you can simply cat
a
		> file to /dev/mtd#
		> > to copy new content to the flash.
		> That sounds nice and seems to be same like the stuff
Wolfgang
		> offered in
		> his 2.4.3-preX patch.

		Yes it is.

		>
		> Matthias
		>
		>
		> --
		> -------------------------------------------------
		> \ Matthias Fuchs                                 \
		>  \ esd electronic system design Gmbh              \
		>   \ Vahrenwalder Straße 205                        \
		>    \ D-30165 Hannover                               \
		>     \ email: matthias.fuchs@esd-electronics.com      \
		>      \ phone: +49-511-37298-0                         \
		>       \ fax:   +49-511-37298-68                        \
		>        --------------------------------------------------
		>
		>
		>

		** Sent via the linuxppc-embedded mail list. See
http://lists.linuxppc.org/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
