Subject: Re: pci on ppc
From: David Woodhouse <dwmw2@infradead.org>
To: Marco Schramel <Schramel.Linux@go.bartec.de>
Cc: PPC_LINUX <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <200406301233.24676.Schramel.Linux@go.bartec.de>
References: <200406301233.24676.Schramel.Linux@go.bartec.de>
Content-Type: text/plain
Message-Id: <1088603444.14216.2865.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Wed, 30 Jun 2004 14:50:44 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2004-06-30 at 12:33 +0200, Marco Schramel wrote:
> Hi,
>
> my kernel does not boot with the kernel option "CONFIG_PCI". (System MPC8270 (PQ2FADS), 2.4.25 denx kernel, eldk 3.0).
> Without the pci option it can boot without problems.
> UBoot supports my pci. It shows the bridge and the cards i put in.
> What i have to attend in the kernel for the 82xx?

Try it in the 2.6 kernel and I'll actually try to care. IF you haven't
_already_ got 2.4 working, why in $DEITY's name would you be starting to
use it now?

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
