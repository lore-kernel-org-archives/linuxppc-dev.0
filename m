Date: Thu, 2 Aug 2001 11:17:35 -0700
From: Matt Porter <mporter@mvista.com>
To: bhupinder sahran <bhup_sah@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: pci-pci bridge initialisation code
Message-ID: <20010802111735.A28848@cx258813-a.chnd1.az.home.com>
References: <20010802205437.5078.qmail@web3801.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010802205437.5078.qmail@web3801.mail.yahoo.com>; from bhup_sah@yahoo.com on Thu, Aug 02, 2001 at 01:54:37PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Aug 02, 2001 at 01:54:37PM -0700, bhupinder sahran wrote:
>
> hi all
> i have ported linux on my MPC8240 processor.
> but as i am not having bios kind of stuff so kernek
> should initialise all the peripherals sitting on the
> pci bus.
> i have intigrated the code, but code for mapping the
> pci-pci bridge is not with me.
> so i cam not see the device which are sitting on bus
> after the bridge.

arch/ppc/kernel/pci_auto.c performs PCI enumeration.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
