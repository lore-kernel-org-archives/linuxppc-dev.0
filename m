From: "Brian Padalino" <bpadalino@perigee.com>
To: "Chris Zimman" <chris@cryptoapps.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: PPCBoot on Ebony board
Date: Wed, 16 Jul 2003 11:39:28 -0400
Message-ID: <DGEEIPOFGGPOACEFBGGCAEHGCAAA.bpadalino@perigee.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20030716142936.GA30975@dingdong.cryptoapps.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am actually stuck with an OCDemon Wiggler JTAG interface.  I was quoted as
being $2300 for the BDI2000.

That is a bit out of my range for this project.  Know anyone selling a used
one?

I guess I will just try to get gdb to work (in cygwin) with this wiggler.

Thanks for everyone's help!

Brian

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Chris
Zimman
Sent: Wednesday, July 16, 2003 10:30 AM
To: Brian Padalino
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPCBoot on Ebony board



On Wed, Jul 16, 2003 at 07:59:28AM -0400, Brian Padalino wrote:
> I found the flash programmer utility, but I am actually a bit scared to
> flash the flash with  the version of PPCBoot that I made.  I am working
> without a JTAG interface, so flashing using JTAG is out of the question,
and
> how would I re-flash if the PPCBoot binary I have doesn't work properly?
Is
> the board running out of EEPROM right now with the IBM Open Shell always
> there?  I have sifted through the documentation a bit, but haven't found a
> straight answer as to exactly how the board is setup right out of the box.

If you built a standard U-Boot 440GP config, odds are that it will work
fine.
If you have a flash programmer, you can always save a copy of the OSOpen
image and then reflash with that if U-Boot doesn't come up right.

I'm not sure if your board is using the EEPROM, but that's only used for
strapping anyway.

> Any sort of help is appreciated.  I am extremely new to ICE, JTAG and such
> embedded systems -- so please, be patient with me (if you can).

The first thing I would recommend you do is to get a BDI2000 JTAG
debugger.  If you're going to be doing any serious work on U-Boot,
Linux, etc. this is one of the most valuable tools you can have.

--Chris


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
