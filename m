Message-ID: <003601c0dc62$dbce25c0$8021690a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: "Hideo Noda" <Hideo_Noda@mutoh.co.jp>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <3ADE42E8.6552066B@mutoh.co.jp>
Subject: Re: PPC405GPWalnutPciBusMaster
Date: Mon, 14 May 2001 18:44:31 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Now I have the same problem as you meet before.
Have you find a good solutions?
Thank you very mcuh.

machael

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
> I think some more settings are needed for PPC405GP built-in PCI control
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
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
