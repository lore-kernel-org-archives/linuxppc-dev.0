Message-Id: <200008151939.VAA00754@piglet.grunz.lu>
Date: Tue, 15 Aug 2000 21:39:21 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: PCI Buses
To: tom_gall@vnet.ibm.com
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <39998FF7.F8B13C1E@vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Tom,

On  15 Aug, this message from tom_gall@vnet.ibm.com echoed through cyberspace:
>   Just a stupid question here for those of you that have Mac hardware. Of all
> the Mac hardware in existance right now, all Macs have at most one PCI bus
> right?

Wrong :-)

As has been said before, the 9x00 have two PCI busses on two identical
bandit host bridges.

Also, the 73/75/76/85/8600 have an additional bus called VCI by Apple,
for accessing video in/out hardware, that behaves exactly like a PCI
bus.

Then, there are newer Macs, with those based on UniNorth having three
PCI buses (AGP counted in).

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
