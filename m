Subject: Re: multiple separate pci bridges ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Marcus Barrow <mbarrow@sangate.com>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040106071412.GB735@iliana>
References: <20040101181145.GA27294@iliana>
	 <1073016223.1502.179.camel@gaston> <20040102074049.GA2032@iliana>
	 <1073029796.1501.228.camel@gaston> <20040104210335.GA858@iliana>
	 <1073252724.780.5.camel@gaston> <20040104220608.GA1667@iliana>
	 <20040105164038.GA16158@iliana>
	 <1073338730.9456.2487.camel@boat.sangate.com> <20040106071412.GB735@iliana>
Content-Type: text/plain
Message-Id: <1073375765.9499.215.camel@gaston>
Mime-Version: 1.0
Date: Tue, 06 Jan 2004 18:56:05 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> Mmm, i understand that the 2.6.x pci domain will make this not
> necessary. I might be wrong though.

What do those register actually do ? Is there a spec of that
host bridge I can download somewhere ?

> > 	If you insert pci cards which contain bridges on them,
> > 	they only work on the bus 0 slots...
>
> bus 1 is used as an agp bus anyway, and i doubt there are many agp
> graphic cards out there with pci bridges on them. When i inserted my
> Appian Jeronimo 2000 in that board, it refused to powerup at all, but
> then, maybe it is drawing too much power or something. After all, it has
> a 3dlabs gamma and two permedia3 on it.
>
> > 	Do you have something like ppcboot or uboot starting
> > 	your system or just a kernel? If you are using a real
>
> Well, there is a customized SmartFirmware OpenFirmware on the board. I
> even have (non-free though) access to the source of it. The board is
> mostly a CHRP design.

It has an x86 BIOS emulator for running the firmwares of the video cards
?

> 	boot rom, you could try initializing the p2p registers
> > 	by hand, then booting...
>
> The Firmware guy told me don't touch it though.
>
> > 	I'm hoping to work on this in the next few days.
>
> Ok, great.
>
> Friendly,
>
> Sven Luther
>
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
