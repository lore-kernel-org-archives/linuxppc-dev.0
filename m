Message-ID: <387C76E6.7CAADBBE@switchboard.ericsson.se>
Date: Wed, 12 Jan 2000 13:43:18 +0100
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: Ruedi.Hofer@ascom.ch
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Antwort: Re: Antwort: 8xxrom wierdness, 2nd
References: <0FO800BEL1WA5U@pmdf-it.hasler.ascom.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



> - Do you have experience with the sandisk pc cards?

Not with pc cards.
But my compact-flash cards with converter works.
I've got cf-cards from Sandisk, Viking and Mitsubishi.
I posted about the wierd Viking card a few weeks ago...

If anyone out there wants support for a certain ATA-card
feel free to send them to me and I will make sure it works! =)

If I were you would I have a look at the data-sheet for the 
pc-card and verify that the ata registers are mapped at the right
positions...

SanDisk has got pretty nice CF manuals and I guess that their pc-card
documentation is good too.
 
> - I formatted the pc card on a win95 box. That should work, right?
>   (At least the boot device list should mention something)

It should work.
 
>> ATA disk: 'SunDisk SDP'.
> 
> Boot device list:Card Not Ready 0x0

It is good that it is able to parse the cis and find out
that it is a ATA disk.

It probably fails when it should send a identify command.

You might need some spinup time if it is a mechanical drive.

Cheers /

magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
