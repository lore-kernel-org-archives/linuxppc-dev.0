From: bob@kunk.jriver.com
Message-ID: <20000915021909.31906.qmail@kunk.jriver.com>
Subject: Re: New topic (PowerPC Linux PCI HELL)
To: linuxppc-dev@lists.linuxppc.org
Date: Thu, 14 Sep 2000 21:19:09 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Vojtech Pavlik <vojtech@suse.cz> wrote:

> The same happens for OHCI on new Macs. The correct function to use is:

> pci_enable_device(dev);

> This function will enable the i/o, mem and irqs, and assign them if they
> were not assigned for some reason, too.

> And you should use it on any PCI device you want to use before using
> it, on all architectures. Also check its return value.

> --
> Vojtech Pavlik
> SuSE Labs

This comment is from my experience with the Rocketport driver port to PPC.

pci_enable_device() is a do nothing call in 2.2.x kernels. It is defined
and supposedly working in 2.3.x/2.4.x kernels. On my 7200, hacks to
enabled verious PCI devices are required with 2.2.x kernels.

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
