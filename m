Date: Wed, 5 Nov 2003 23:07:16 -0800
From: Brad Boyer <flar@allandria.com>
To: Jeff Walther <trag@io.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IRQS on 6 Slot Macs
Message-ID: <20031106070716.GB17235@pants.nu>
References: <1067842481.17970.8.camel@gaston> <a04310106bbcd1501d614@[199.170.89.118]> <1067937269.680.92.camel@gaston> <a04310102bbcda40d92fc@[199.170.89.159]> <1067985081.707.124.camel@gaston> <a04310101bbce0854283b@[199.170.89.118]> <1068000383.692.132.camel@gaston> <a04310100bbce446f4c17@[199.170.89.149]> <1068016722.12704.148.camel@gaston> <a04310103bbcedf04902a@[199.170.89.149]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a04310103bbcedf04902a@[199.170.89.149]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 05, 2003 at 11:39:33AM -0600, Jeff Walther wrote:
> At 18:18 +1100 11/05/2003, Benjamin Herrenschmidt wrote:
> >> The SCSI cell in CURIO is a 53C94, but CURIO provides SCSI, ethernet
> >> and serial port support all in one chip.   So the pinout of the 53C94
> >> doesn't tell one about the pinout of CURIO, except it does identify
> >> some of the pins which must be present on CURIO somewhere.
>
> CURIO is an interesting chip.   It has the unenhanced SCSI (53C94),
> MACE and ESCC all on one chip.   It's an AMD chip and has no Apple
> markings on it at all, which implies that it is a generally available
> AMD product.   Checking their listings of datasheets, one finds
> several similar chips and a part number series that would include the
> 79C950 but no listing for the datasheet for the CURIO/79C950.
> Usually when Apple has a chip made just for Apple it has Apple
> markings on it somewhere.   So I'm uncertain what the deal is with
> CURIO.
>
> Anyway, it wasn't a case of splitting an ASIC.   As closely as GC and
> CURIO work together that's a reasonable conclusion.   But CURIO was
> used in the x100 NuBus PowerMacs before they put it in the x500
> series.   So CURIO had a couple of years of history before GC showed
> up.

I just looked, and the Quadra 840AV has a chip on the motherboard with
an AMD logo and the part number AM79C950KC. And as a noteworthy fact,
the AV models were the only 68k models to have a number of features,
including using the MACE ethernet and having DMA on the serial ports.
All the other 68k Macs with onboard Ethernet use the sonic driver.
Supposedly the AV models also had an AMD chip controlling the floppy
drive, but this is the only AMD labelled chip. Perhaps it has more
features than SCSI, Ethernet, and serial? There are several very
large Apple ASICs, tho...

	Brad Boyer
	flar@allandria.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
