Message-ID: <3C0BE2DA.53C39E1B@seranoa.com>
Date: Mon, 03 Dec 2001 15:38:50 -0500
From: Andrew Dixon <andrew.dixon@seranoa.com>
MIME-Version: 1.0
To: ppclist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: programming ppcboot onto an sbc8260 with a vision ice
References: <3C0BD4F1.DB6591F3@seranoa.com> <3C0BDBB4.68EB3E72@chinook.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Peter Desnoyers wrote:
>
> You need to take the ELF file, ppcboot, and convert it into a .bin file
> using the vision ICE convert utility.
>
> The file format referred to as "BIN" in the visionICE documentation
> isn't a real binary image - it has a special header.
>

OK.  When I try that it tells me:

Conversion Failed: no data was extracted from the selected address
range.

Where the address ranges are:
/var/opt/visionXD/bin/convert  -w ppcboot -b
convert v7.8A Copyright (c) 1996-2001 Wind River HSI
convert ELF file ppcboot to BDX file ppcboot.bdx
Extracting image from 'ppcboot'
Writing binary download image to 'ppcboot.bdx'
Maximum packet size: 0x100
Lower address: 0x0
Upper address: 0xffffffff
Execution address: 0x40000000
Image written
Processing time: 0.011 seconds

Lower Image Address: 0xfe000000
Upper Image Address: 0xfe020000


I also tried:

/var/opt/visionXD/bin/convert  -w ppcboot -b
convert v7.8A Copyright (c) 1996-2001 Wind River HSI
convert ELF file ppcboot to BDX file ppcboot.bdx
Extracting image from 'ppcboot'
Writing binary download image to 'ppcboot.bdx'
Maximum packet size: 0x100
Lower address: 0x0
Upper address: 0xffffffff
Execution address: 0x40000000
Image written
Processing time: 0.011 seconds

which gives me a file "ppcboot.bdx".  VisionXD still complains that it's
not a flat binary though.

Any thoughts?

Thanks,
Andy

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
