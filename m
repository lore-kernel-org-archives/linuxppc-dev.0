To: "Brian Padalino" <bpadalino@perigee.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PPCBoot on Ebony board
References: <DGEEIPOFGGPOACEFBGGCOEHCCAAA.bpadalino@perigee.com>
From: Roland Dreier <roland@topspin.com>
Date: 16 Jul 2003 07:45:17 -0700
In-Reply-To: <DGEEIPOFGGPOACEFBGGCOEHCCAAA.bpadalino@perigee.com>
Message-ID: <52u19mr0n6.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    Brian> I found the flash programmer utility, but I am actually a
    Brian> bit scared to flash the flash with the version of PPCBoot
    Brian> that I made.  I am working without a JTAG interface, so
    Brian> flashing using JTAG is out of the question, and how would I
    Brian> re-flash if the PPCBoot binary I have doesn't work
    Brian> properly?  Is the board running out of EEPROM right now
    Brian> with the IBM Open Shell always there?  I have sifted
    Brian> through the documentation a bit, but haven't found a
    Brian> straight answer as to exactly how the board is setup right
    Brian> out of the box.

The Ebony OpenBIOS runs out of the socketed EEPROM on the board.  Just
pop the current EEPROM, put a sticker on it that says "Original
Bootloader" and use a new EEPROM for PPCBoot testing.

 - Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
