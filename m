MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: flash writing with Linux
Date: Mon, 19 Mar 2001 17:31:29 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E3108AFE4@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <karid@flaga.is>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: Matthias Fuchs [mailto:matthias.fuchs@esd-electronics.com]
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
> > Perhaps you can take a look at mtd and use that to manage
> your flash.
> > With mtd you can partition your flash to different devices
> and erase them
> > selectively.
> What is mtd ? Never heard of before !

It is flash abstracation layer (driver), and is now part of the
official linux 2.4.x kernels from Linus.
http://www.mtd-infradead.org

> >
> > Once you have your flash partitioned you can simply cat a
> file to /dev/mtd#
> > to copy new content to the flash.
> That sounds nice and seems to be same like the stuff Wolfgang
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

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
