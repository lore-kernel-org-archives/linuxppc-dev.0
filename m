Mime-Version: 1.0
Message-Id: <p05101000b82a6b5266c7@[10.0.0.42]>
In-Reply-To: <20011127155855.G10071@plato.local.lan>
References: <20011126231944.E10071@plato.local.lan>
 <20011127172847.33B512B54A@marcus.pants.nu>
 <20011127155855.G10071@plato.local.lan>
Date: Wed, 28 Nov 2001 02:40:09 -0800
To: Ethan Benson <erbenson@alaska.net>,
	linuxppc <linuxppc-dev@lists.linuxppc.org>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: TiBook, 1394, iPod working (sort of  ;-)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 3:58 PM -0900 11/27/01, Ethan Benson wrote:
>On Tue, Nov 27, 2001 at 09:28:47AM -0800, Brad Boyer wrote:
>>
>>  Well, according to Apple's documentation, the only version of HFS+
>>  is version 4, so I have no idea what's up with that...
>
>well it also doesn't document things like the permission bits, it just
>says they are unused and reserved, obviously this is not the case
>given OSX, apple just has not updated this document.
>
>that means theres a bit of reverse engineering involved as well since
>apple is using a newwer version of HFS+ which is not entirely
>documented.

The documentation is the source now, it would seem.  (just like much
of Linux :)  See:

   xnu-9-1/bsd/hfs/

in the Darwin kernel (aka "xnu") source.  hfs_format.h defines the
on-disk layout, including the structure used for storage of
permission bits.

 From the information in that file it looks like the HFS+ version is
still 4, BTW.

Looks like it should even be possible to figure out how Apple did the
hard- and soft-link hacks.  Maybe one day Linux will be able to boot
directly from HFS+ just as Darwin does.  That would be perverse.  :)
--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
