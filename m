Message-ID: <3FAC089B.1060203@2net.co.uk>
Date: Fri, 07 Nov 2003 21:03:23 +0000
From: Chris Simmonds <chris@2net.co.uk>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCI for mpc8270
References: <3FA7A8C5.2020702@2net.co.uk> <008b01c3a339$5ddc7c20$4b01a8c0@shang> <3FA8536A.6080101@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

Thanks, I have included that code in my kernel and it seems to be
working ok - haven't really tested it yet but at least bus enumeration
works.

This code is based on the PCI 9 workaround for the bug in the 8265,
which uses an IDMA channel for all access. Has anybody looked at doing a
version without the woorkaround? Would it make any difference to the
performance of the system?

Bye for now,
Chris.



Dan Malek wrote:

> shanggao wrote:
>
>> If  mpc8270 has 60x bus,I think you can use
>> CPC710,MV64361....................
>
>
> The 8270 has the internal PCI bridge, like the 8265/66.
> The linuxppc_2_4_devel kernel has the PCI functions and setup
> for the 8266 on the Motorola ADS board.  It would be a
> starting point for you.
>
>
>     -- Dan
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
