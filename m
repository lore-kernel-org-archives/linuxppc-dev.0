Message-ID: <A109131318C4D1119AC20060088DECE35732E9@mail.adaptivemicro.com>
From: Cindy Peters <cinpet@adaptivemicro.com>
To: "'Dan Malek'" <dan@mvista.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: New Linux PowerPC development
Date: Tue, 31 Jul 2001 16:39:17 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


-----Original Message-----
From: Dan Malek [mailto:dan@mvista.com]
Sent: Tuesday, July 24, 2001 12:27 PM
To: Cindy Peters
Cc: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Re: New Linux PowerPC development


Dan Malek wrote:

>Cindy Peters wrote:

>> The MPC823, however, does not have an IDE or PCI interface for a hard
disk.

>Sure it does.  Just use the PCMCIA.

>> We feel we would have to design an interface into an FPGA.

>This is also a solution many people use.  Lots less expensive and
>less complex than a PCI adapter.

We have just recently been instructed by management to stay with the MPC823
in order to re-use the previous software and hardware development as much as
possible. We are looking at using some VHDL IP provided by Open Cores (this
is very new) for the IDE interface. Are you familiar with this?

The VHDL code uses a processor independent interface called a wishbone
interface. I don't know much about it yet. I don't know if this is something
standard or just developed for Open Cores. Do you (or anyone else) know of
any driver software that may be available for this interface?

>	-- Dan

Also, I am trying to determine the approximate time it takes the 823 to
access memory (i.e. external EDO DRAM). Does anyone know?

I have downloaded the lmbench software to determine some benchmarking
information. I am not sure how to build it for the PPC. I have a cross
compiler development environment setup in a subdirectory. Can someone help
me with this?

Thanks.
Cindy


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
