Date: Fri, 10 Mar 2000 10:55:09 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Patrick Lerda <Lerda@microprocess.com>
cc: David Monro <davidm@amberdata.demon.co.uk>,
        Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: RE: IBM 850 - Open Firmware or not? and more on the ide byteswapg
 ame...
In-Reply-To: <902CA06399F5D311AAAC00500422FC63094031@iis000.microdata.fr>
Message-ID: <Pine.HPX.4.10.10003101024360.22162-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 9 Mar 2000, Patrick Lerda wrote:

> I think porting Linux PPC to little endian could be a great idea. Now, all
> systems
> use PCI, and little endian is the native mode of this bus. Trying
> to get all PCI hardware well supported on Linux i386 working on a PowerPC
> box
> is an headache, and a lot of drivers and programs don't work proberly for
> only one
> reason: endianess... Using PowerPC in big endian mode is only understandable
> in closed
> computers like iMac.

I happen to strongly disagree (and I don't think at all that it's a
headache, it's fairly easy), but if you want to start a ppcel port, go
ahead. I just won't use it.

Endianness is just the tip of the iceberg and is mostly transparent thanks
to the bridges preserving byte addresses for all transfers. There are at
least 2 other pure BE ports of Linux, m68k and sparc (split into sparc and
sparc64), the SPARC having PCI buses (some 68k might have PCI buses as
well). The MIPS port is bi-endian AFAICT...

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
