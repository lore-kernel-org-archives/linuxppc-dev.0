From: "Brian Padalino" <bpadalino@perigee.com>
To: "Chris Zimman" <chris@cryptoapps.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: PPCBoot on Ebony board
Date: Wed, 16 Jul 2003 07:59:28 -0400
Message-ID: <DGEEIPOFGGPOACEFBGGCOEHCCAAA.bpadalino@perigee.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20030715213254.GA27907@dingdong.cryptoapps.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I found the flash programmer utility, but I am actually a bit scared to
flash the flash with  the version of PPCBoot that I made.  I am working
without a JTAG interface, so flashing using JTAG is out of the question, and
how would I re-flash if the PPCBoot binary I have doesn't work properly?  Is
the board running out of EEPROM right now with the IBM Open Shell always
there?  I have sifted through the documentation a bit, but haven't found a
straight answer as to exactly how the board is setup right out of the box.

Any sort of help is appreciated.  I am extremely new to ICE, JTAG and such
embedded systems -- so please, be patient with me (if you can).

Sincerely,
Brian Padalino


-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Chris
Zimman
Sent: Tuesday, July 15, 2003 5:33 PM
To: Brian Padalino
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPCBoot on Ebony board



On Tue, Jul 15, 2003 at 02:11:07PM -0400, Brian Padalino wrote:
>
> I am trying to transfer PPCBoot that I had compiled over a tftp session in
> the 440GP 1.18 ROM Monitor (02/11/02) that came on the Ebony board.  Is
that
> the wrong method of trying it?  I tried using both serial ports and Kermit
> with Xon/Xoff handshaking, but it just ended up timing out.
>
> I keep getting the error:
>   Loading file "C:\ppc\bootp\boot.img" ...
>   Sending tftp boot request ...
>   Not a valid boot image file
>
> Which stems from an improper magic number at the top of the file to say
it's
> a valid boot image.

This is not going to work.  You want to program PPCBoot into flash via a
flash programmer or via JTAG.

--Chris


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
