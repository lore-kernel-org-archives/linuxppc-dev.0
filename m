Message-ID: <3C0BDBB4.68EB3E72@chinook.com>
Date: Mon, 03 Dec 2001 15:08:20 -0500
From: Peter Desnoyers <pdesnoyers@chinook.com>
MIME-Version: 1.0
To: Andrew Dixon <andrew.dixon@seranoa.com>
Cc: ppclist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: programming ppcboot onto an sbc8260 with a vision ice
References: <3C0BD4F1.DB6591F3@seranoa.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You need to take the ELF file, ppcboot, and convert it into a .bin file
using the vision ICE convert utility.

The file format referred to as "BIN" in the visionICE documentation
isn't a real binary image - it has a special header.

Andrew Dixon wrote:
>
> Hi All,
>
> I'm trying to put ppcboot onto my sbc8260 board using a vision ice and I
> was wondering if there is a preferred way to do this?  I've compiled
> ppcboot on a native gcc-2.95 with the commands:
>
> $make sbc8260_config
> $make
>
> and I get a binary file ppcboot.bin.  When I try to program the
> ppcboot.bin onto the flash it complains that the format is not
> recognized as mpc8260 code.
>
> Any ideas on what I'm doing wrong?
>
> Thanks,
> Andy
>

--
.....................................................................
 Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
 Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
 100 Hayden Ave, Lexington MA 02421

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
