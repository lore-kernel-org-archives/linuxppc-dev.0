Message-ID: <3B69C951.16325151@mvista.com>
Date: Thu, 02 Aug 2001 14:42:41 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: bhupinder sahran <bhup_sah@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: pci-pci bridge initialisation code
References: <20010802205437.5078.qmail@web3801.mail.yahoo.com> <3B69C8D8.9EE9E343@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Mark A. Greer" wrote:

> bhupinder sahran wrote:
>
> > hi all
> > i have ported linux on my MPC8240 processor.
> > but as i am not having bios kind of stuff so kernek
> > should initialise all the peripherals sitting on the
> > pci bus.
> > i have intigrated the code, but code for mapping the
> > pci-pci bridge is not with me.
> > so i cam not see the device which are sitting on bus
> > after the bridge.
> > can anybody tell me where i can get this code.
> > thanks in advance
> > with king regards
>
> I'm not sure I really understood everything you're trying to say but you can
> start looking in mpc10x_common.c for some mpc105/106//107/8240 bridge init
> code.  You can look at the sandpoint port for how to use it.  This code should
> do most if not all of what you need to do.

I guess I should add that if you really mean setting up a PCI-PCI bridge (and not
the host bridge), try using the pci_auto stuff.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
