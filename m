Date: Mon, 15 Jan 2001 17:13:41 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: bk 2.4.1pre2 Lombard PCI allocation fails.
In-Reply-To: <20010115081732.43695DB9FD@atlas.valhalla.net>
Message-ID: <Pine.LNX.4.30.0101151710020.9336-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> as the title says...
> The machine boots and (seems) OK.
>
> FWIW: I boot this machine with BootX [1.2.2] (and always have, without
> problem, until this time).
> PCI: Cannot allocate resource region 2 of device 00:11.0
> PCI: Resource 80880000-80880fff (f=200, d=0, p=0)
> PCI: Resource 00000c00-00000cff (f=101, d=1, p=1)
> PCI: Cannot allocate resource region 1 of device 00:11.0
>   got res[10000000:10000fff] for resource 2 of ATI Technologies Inc 3D Rage
> LT Pro

BootX uses the MacOS PCI mappings which are bogus for the Rage LT Pro.
Though I'm certain Geert's old PCI resource allocation patch worked fine
in spite of this. There was some message about resource conflict but that
was fixed by the kernel.

What's the PCI resourced for the card after the kernel has finished
booting?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
