From: "Stefan Roese" <stefan.roese@esd-electronics.com>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: AW: PPC405GPWalnutPciBusMaster
Date: Thu, 19 Apr 2001 10:07:55 +0200
Message-ID: <EFEAIMDCOOOHIEPHDNFJOEFGCMAA.stefan.roese@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20010418193652.B19053@ecam.san.rr.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> On Thu, Apr 19, 2001 at 10:44:08AM +0900, Hideo Noda wrote:
> > Has anyone tried PCI cards with BUS MASTER operations for Walnut
> > PPC405GP?
>
> I have tried and failed. I have other things to work on right now
> so I have just delayed looking into it anymore until the 2.0 CDK
> comes out. I think that should be by the end of the month.
>
> I think there is a problem with the virt_to_phys matching the
> PTM1/BAR1. In the preliminary 405gp docs that I have Fig 17-59
> on page 17-62 give a good overview on how things need to be
> setup on the chip, but I am not sure on what the values
> need to be.

Which bootloader/firmware are you using? The pci configuration should be
done within the bootloader. If you are using PPCBoot, I am not shure if the
configuration is correct regarding the busmaster setup (although I did the
port based on the IBM OpenBios). The bus master functionality was never
tested - sorry for that.

Stefan.

*******************************************
esd gmbh
Vahrenwalder Str. 205
D-30165 Hannover
Phone: +49-511-37298-0
Fax:   +49-511-37298-198
email: stefan.roese@esd-electronics.com
www:   http://www.esd-electronics.de
*******************************************


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
