Message-ID: <3ADE42E8.6552066B@mutoh.co.jp>
Date: Thu, 19 Apr 2001 10:44:08 +0900
From: Hideo Noda <Hideo_Noda@mutoh.co.jp>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: PPC405GPWalnutPciBusMaster
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am trying to install Intel eepro100 onto WalnutPPC405GP.
Basic PCI settings seem good but no frame is transmitted.
The environment is WalnutPPC305GP with HardHatLinux 2.4.2 from
MonraVista.

I can read or write eepro configuration registers and other control
registers via PCI memory space.
But Bus Master operations do not seem functional. I am confirmed that
MASTER operation bit in eepro100 is enabled.
I think some more settings are needed for PPC405GP built-in PCI control
registers and/or Walnut board jumpers/dipswitches.

Has anyone tried PCI cards with BUS MASTER operations for Walnut
PPC405GP?

Thanks in advance,

Hideo


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
