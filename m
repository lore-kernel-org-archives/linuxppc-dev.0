Date: Tue, 22 Aug 2000 09:58:25 -0700
From: Matt Porter <mporter@mvista.com>
To: Michael Lundkvist <ml@epact.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IP over a PCI-bus
Message-ID: <20000822095825.A31482@cx258813-a.chnd1.az.home.com>
References: <qpk8d9plq4.fsf@erbium.epact.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <qpk8d9plq4.fsf@erbium.epact.se>; from ml@epact.se on Tue, Aug 22, 2000 at 01:40:51PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Aug 22, 2000 at 01:40:51PM +0200, Michael Lundkvist wrote:
>
> I thinking about running Linux on a system consisting of a MVME-2300
> or MVME-2400 VME-carrierboard together with a PMC 860 module.
>
> The PMC doesn't have it's own ethernet interface and I would like to
> be able to communicate with the carrier board over the PCI bus using
> IP.
>
> Has anyone done any work on a network driver for a system like that?

MontaVista's Hard Hat Net is a PCI shared memory "Ethernet" driver.  It
relies on having a 21554 bridge to detect nodes and gather information
about them.  It is modular enough that you can add a different detection
method for your 860 PMC's PCI bridge.

Available at ftp://ftp.mvista.com/pub/hhnet/

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
