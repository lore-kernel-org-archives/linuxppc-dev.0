Mime-Version: 1.0
Message-Id: <a04310100bbd028c69585@[199.170.90.7]>
In-Reply-To: <20031106070716.GB17235@pants.nu>
References: <1067842481.17970.8.camel@gaston>
 <a04310106bbcd1501d614@[199.170.89.118]> <1067937269.680.92.camel@gaston>
 <a04310102bbcda40d92fc@[199.170.89.159]>
 <1067985081.707.124.camel@gaston>
 <a04310101bbce0854283b@[199.170.89.118]>
 <1068000383.692.132.camel@gaston>
 <a04310100bbce446f4c17@[199.170.89.149]>
 <1068016722.12704.148.camel@gaston>
 <a04310103bbcedf04902a@[199.170.89.149]> <20031106070716.GB17235@pants.nu>
Date: Thu, 6 Nov 2003 10:44:44 -0600
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
From: Jeff Walther <trag@io.com>
Subject: Re: IRQS on 6 Slot Macs
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 23:07 -0800 11/05/2003, Brad Boyer wrote:

>I just looked, and the Quadra 840AV has a chip on the motherboard with
>an AMD logo and the part number AM79C950KC. And as a noteworthy fact,
>the AV models were the only 68k models to have a number of features,
>including using the MACE ethernet and having DMA on the serial ports.
>All the other 68k Macs with onboard Ethernet use the sonic driver.
>Supposedly the AV models also had an AMD chip controlling the floppy
>drive, but this is the only AMD labelled chip. Perhaps it has more
>features than SCSI, Ethernet, and serial? There are several very
>large Apple ASICs, tho...

Thank you.  So CURIO goes all the way back to the AV Quadras.    I
thought I had read that but wasn't certain.   I know it doesn't go
any further back because I have examples of the Q650/800  and Q700
boards handy and they definitely don't use it.

According to Apple's Developer Note for the AV Quadras,
"Centris_660AV_Quadra_840AV.pdf" the floppy controller is a separate
chip called "New Age".    I would expect it to be relatively small,
probably 40 or 44 pins in a PLCC package, but that's a guess based on
Apple's other floppy controllers.

I think CURIO is limited to the three features listed.

The SWIM is a separate chip in the x100 Macs, but I think it's
integrated into GC in the x500 Macs.    Let's see, from
"PPC_9500.pdf":

"The Grand Central IC performs the following functions:
     support for the Cuda IC (the VIA registers)
     central system interrupt collection
     support for descriptor-based DMA for I/O devices
     floppy disk interface (SWIM III)

"The Grand Central IC contains a DMA controller. It provides DBDMA
support for all I/O transfers, including transfers through its
internal I/O controllers as well as transfers through the Curio IC
for other I/O devices."

Jeff Walther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
