Date: Thu, 9 Mar 2000 16:24:11 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Patrick Lerda <Lerda@microprocess.com>
cc: David Monro <davidm@amberdata.demon.co.uk>,
        "'Gabriel Paubert'" <paubert@iram.es>,
        Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: RE: IBM 850 - Open Firmware or not? and more on the ide byteswapg
 ame...
In-Reply-To: <902CA06399F5D311AAAC00500422FC63094031@iis000.microdata.fr>
Message-ID: <Pine.LNX.4.10.10003091621020.24076-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


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

Nothing wrong with starting a new port (ppc-le). Might be faster than
getting all those i386 driver authors to fix their endianness problems,
after all.

You'd probably sacrifice binary compatibility with existing LinuxPPC
software, but hey - who'd want to run Linux binaries that would run on an
iMac anyway?

</sarcasm off>

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
