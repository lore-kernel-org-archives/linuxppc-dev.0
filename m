Message-ID: <3B838D6F.9D38C454@inn.ericsson.se>
Date: Wed, 22 Aug 2001 12:46:07 +0200
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
MIME-Version: 1.0
To: Scott Anderson <scott_anderson@mvista.com>
Cc: Felix Radensky <felix@allot.com>,
	Linix PPC Emmbedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BDI2000 vs RiskWatch
References: <3B8212A6.9AF31020@allot.com> <3B829C48.64C5FCDF@mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Scott Anderson wrote:
>
> Felix Radensky wrote:
> > Can someone please explain what BDI2000 can do that RiskWatch cannot.

> Bottom line: If you are developing on Windows, the RiscWatch is probably
> what you want.  If you are developing on Linux (which I hope is the
> case), you want a BDI2000.  Otherwise, you're going to need a Windows
> box for RiscWatch to run on and then you'll have to set up Samba or some
> other mechanism for the Windows box/RiscWatch to see your sources, etc.

No the RiscWatch is as useless in wondows as it's under unix.

To be fair RiscWatch is not one product but two separate entites. The
hardware part is marked IBM RiscWatch but is in fact a box from hp(agilent).
To control this hardware you just have to telnet into it.

The software part is the one that sucks and I REALLY mean that. I had a hell
trying to get this to work. To begin with the software can't be used on any
Xdisplay that uses 16 bith depth it just crash. This is not entierly easy to
figure out when all displays is running in this mode and the IBM people don't
know about this problem. Solution run in 8 bit :(

Then is came a bit longer but hang when it was trying to flash the hp box
with software for the version of cpu I was using. Several visit's by IBM
people could not solv this problem so they gave me a box on loan that had the
right software already inside.

Now I could run commands like reset and singelstep but the run command
resulted in the software hanging again but the target cpu was at least
running. So I could set up registers and stuff and do one run. Not very
usefull mode :(

Then came summer time (daylight saving time) and now without me doing
anything it worked more or less as intened ?????  But only if run from
solaris 2.7 not from solaris 2.6 ?

Then it seems to have a life on it's own. The "reset system" command has
always done a complete reset and the cpu has started as normal from
flash/rom. But a few weeks ago it nolonger can start from ROM as for some
reason a reset system fails to put valid entry into chip select 0 registers
making an access to fffffffc invalid :(

Well my recomendations is to stay far away from this software. The hardware
part is probably ok and you can buy just the hardware but as it needs to be
programmed to the target cpu you use and that is in the software package in
practice you need both.

It is probably quite easy to interface the hardware with gdb but you need to
snoop what RiscWatch dose as the help for the telnet interface in the hp box
is to little to be usefull.

I have not used BDI2000 so I can't really say anything about it but my
recomendation is anything BUT RiscWatch.

--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
