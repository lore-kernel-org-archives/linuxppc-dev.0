Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10163E245@cceexc19.americas.cpqcorp.net>
From: "Cagle, John" <John.Cagle@compaq.com>
Reply-To: jcagle@kernel.org
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: PPC405GPWalnutPciBusMaster
Date: Thu, 19 Apr 2001 10:06:34 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Try this command before loading the eepro100 driver module:

	setpci -s 0:0.1 14.L=0x8

It seems that the latest openbios doesn't program the PCI bridge registers
appropriately.

Regards,
John
jcagle@kernel.org

> -----Original Message-----
> From: Hideo Noda [mailto:Hideo_Noda@mutoh.co.jp]
> Sent: Wednesday, April 18, 2001 8:44 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: PPC405GPWalnutPciBusMaster
>
>
>
> Hi,
>
> I am trying to install Intel eepro100 onto WalnutPPC405GP.
> Basic PCI settings seem good but no frame is transmitted.
> The environment is WalnutPPC305GP with HardHatLinux 2.4.2 from
> MonraVista.
>
> I can read or write eepro configuration registers and other control
> registers via PCI memory space.
> But Bus Master operations do not seem functional. I am confirmed that
> MASTER operation bit in eepro100 is enabled.
> I think some more settings are needed for PPC405GP built-in
> PCI control
> registers and/or Walnut board jumpers/dipswitches.
>
> Has anyone tried PCI cards with BUS MASTER operations for Walnut
> PPC405GP?
>
> Thanks in advance,
>
> Hideo
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
