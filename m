Date: Thu, 13 Sep 2001 17:57:03 +0200
From: Xavier Grave <grave@ipno.in2p3.fr>
To: Matt Porter <mporter@mvista.com>
Cc: Xavier Grave <grave@ipno.in2p3.fr>,
	dev ppc <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mvme5100 memory model ?
Message-ID: <20010913175703.C6152@ipnpcu5.in2p3.fr>
References: <20010913162250.C5558@ipnpcu5.in2p3.fr> <20010913051235.A7990@cx258813-a.chnd1.az.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <20010913051235.A7990@cx258813-a.chnd1.az.home.com>; from mporter@mvista.com on jeu, sep 13, 2001 at 14:12:35 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > "chrp-like".  CFGA and CFGD are not at chrp compliant locations
> due to limitations of the hawk smc.  As far as PCI I/O and Mem
> space, it is the same.

One more question so : why the Hawk chip doesn't appear in the /proc/iomem
?

Last question for today :-)

  pci_read_config_dword(carte.pci,PCI_BASE_ADDRESS_0,&tmp);
  carte.bus_delta = carte.pci->resource[0].start - tmp;

on the mvme2303 board this code gives a bus delta = 0xc000 0000
so with your last information (chrp like) I am waiting for a 0x4000 0000
value
for the mvme5100 board. I am getting 0x0000 0000 on the mvme5100 board.

Any idea why ?

Thanks in advance for any answer.

O+ xavier

--
33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
