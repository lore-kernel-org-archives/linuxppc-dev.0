Message-ID: <39DA9BB7.61BD963E@mvista.com>
Date: Tue, 03 Oct 2000 22:53:43 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: SangTae Ha <stha@netstech.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC850 and ATA/IDE
References: <085701c02daa$2d8a9140$2a6cabd3@dolbae>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


SangTae Ha wrote:
>
> Hi,
> I am looking for the solution that I can use ATA/IDE general hard disk

There are at least three easy and inexpensive ways people add ATA/IDE
to the 8xx processors for embedded systems:

	Connect to PCMCIA interface
	Use a simple CPLD between the processor bus and disk
	Program one of the UPMs to generate timing and then
		externally buffer the signals

>  MPC860 or MPC821 CPU is used and Wind bond 83C553

It is a more difficult solution on the 850 because of the PCI bridge
(fewer
physical address lines).  It is also the most expensive in money, board
space and software.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
