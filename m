Date: Tue, 15 May 2001 22:58:27 -0700
From: John Cagle <jcagle@kernel.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC405GPWalnutPciBusMaster
Message-ID: <20010515225827.A32334@kernel.org>
References: <3ADE42E8.6552066B@mutoh.co.jp> <003601c0dc62$dbce25c0$8021690a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <003601c0dc62$dbce25c0$8021690a@huawei.com>; from dony.he@huawei.com on Mon, May 14, 2001 at 06:44:31PM +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Until a newer kernel is released by Monta Vista that includes a fix,
you can use setpci to change the settings of the PCI bridge as follows:

  setpci -s 0:0.1 14.L=0x8

Then you should be able to "insmod eepro100"...

Regards,
John

On Mon, May 14, 2001 at 06:44:31PM +0800, machael thailer wrote:
>
> Now I have the same problem as you meet before.
> Have you find a good solutions?
> Thank you very mcuh.
>
> machael
>
> >
> > Hi,
> >
> > I am trying to install Intel eepro100 onto WalnutPPC405GP.
> > Basic PCI settings seem good but no frame is transmitted.
> > The environment is WalnutPPC305GP with HardHatLinux 2.4.2 from
> > MonraVista.
> >
> > I can read or write eepro configuration registers and other control
> > registers via PCI memory space.
> > But Bus Master operations do not seem functional. I am confirmed that
> > MASTER operation bit in eepro100 is enabled.
> > I think some more settings are needed for PPC405GP built-in PCI control
> > registers and/or Walnut board jumpers/dipswitches.
> >
> > Has anyone tried PCI cards with BUS MASTER operations for Walnut
> > PPC405GP?
> >
> > Thanks in advance,
> >
> > Hideo

------------------------------
John Cagle <jcagle@kernel.org>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
