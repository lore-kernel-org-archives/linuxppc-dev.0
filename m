From: acmay@acmay.homeip.net
Date: Thu, 19 Apr 2001 08:05:45 -0700
To: Stefan Roese <stefan.roese@esd-electronics.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PPC405GPWalnutPciBusMaster
Message-ID: <20010419080545.C1111@sink.san.rr.com>
References: <20010418193652.B19053@ecam.san.rr.com> <EFEAIMDCOOOHIEPHDNFJOEFGCMAA.stefan.roese@esd-electronics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EFEAIMDCOOOHIEPHDNFJOEFGCMAA.stefan.roese@esd-electronics.com>; from stefan.roese@esd-electronics.com on Thu, Apr 19, 2001 at 10:07:55AM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Apr 19, 2001 at 10:07:55AM +0200, Stefan Roese wrote:
>
> > On Thu, Apr 19, 2001 at 10:44:08AM +0900, Hideo Noda wrote:
> > > Has anyone tried PCI cards with BUS MASTER operations for Walnut
> > > PPC405GP?
> >
> > I have tried and failed. I have other things to work on right now
> > so I have just delayed looking into it anymore until the 2.0 CDK
> > comes out. I think that should be by the end of the month.
> >
> > I think there is a problem with the virt_to_phys matching the
> > PTM1/BAR1. In the preliminary 405gp docs that I have Fig 17-59
> > on page 17-62 give a good overview on how things need to be
> > setup on the chip, but I am not sure on what the values
> > need to be.
>
> Which bootloader/firmware are you using? The pci configuration should be
> done within the bootloader. If you are using PPCBoot, I am not shure if the
> configuration is correct regarding the busmaster setup (although I did the
> port based on the IBM OpenBios). The bus master functionality was never
> tested - sorry for that.

I am just using the OpenBios for now. We will be spinning our own board
within the year so I was going to delay looking into doing the PPCBoot
code until then. I was able to look at the PCI registers when the kernel
booted and they appeared to be OK. For the hell of it I tried to change them
in the kernel and it hung during boot. I did not see in the docs the constraints
on when I could change those registers. Is it possible to do it very early in
the Linux boot code?
Thanks
--
Andrew May


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
