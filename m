Message-ID: <38E338CB.A0BCD656@switchboard.ericsson.se>
Date: Thu, 30 Mar 2000 13:21:47 +0200
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: Eisenzopf Thomas <thomas.eisenzopf@siemens.at>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8xxROM with MPC860ADS - ATA Flash Card not recognized?
References: <D53137D1F3DDD211A3750800060DA31301702394@viee122a.erd.siemens.at>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eisenzopf Thomas wrote:
>
> Hallo,
>
> does anyone know this problem:
>
> Using 8xxROM on a MPC860ADS board does not recognize my ATA flash card in
> the PCMCIA slot (SanDisk compact flash with PCMCIA adapter). In the
> beginning of the bootloader startup I get the message "pcmcia: no card
> present". Parts of my "config.h" (I tried with and without PCMCIABUG):

I think Raphael Bossek made some FADS823 changes to this code.
The 823 use pcmcia port B and the (F)ADS860 use port A.
Check the init code for the pcmcia controller, it is hardcoded to port B right now...

And.. ..you need to use PCMCIABUG with your ADS.

Cheers /

magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
