Date: Mon, 9 Jul 2001 09:20:21 -0700 (MST)
From: Jeff Rugen <jprugen@earthlink.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Jeff Rugen <jprugen@earthlink.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: RTC and SCSI for PowerStack/2.4.6 Kernel
In-Reply-To: <20010709075703.G825@opus.bloom.county>
Message-ID: <Pine.LNX.4.21.0107090842230.1593-100000@raptor.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 9 Jul 2001, Tom Rini wrote:

> Did you do any fixes/cleanups to clgenfb?  I took a stab and trying to
> re-do your PReP fixes in it a while back, but I don't think it ever got
> into the main tree.
>

No, I don't have any changes from the official 2.4.6 kernel except for
adding __ in front of a couple functions (change_bit and
test_and_change_bit, I think) in one or two places, and some code where I
was experimenting with setting the parallel port in ECP or EPP
mode.  Everything else appears to be whitespace differences or in drivers
that I'm not using or don't seem to work (quickcam and 53c7,8xx).

I did have VGA console be the default, and installed clgenfb as a module.

On a related note, the endianness issue with gpm seems to also show up
when running the VGA console -- any text that is written to a non-visible
virtual terminal is not byte-swapped, so it appears to be garbage when you
switch back to that virtual terminal.  This isn't a problem when running
clgenfb as the terminal though (I don't know how gpm worked in either
mode).

Jeff Rugen


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
