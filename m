Date: Tue, 23 Jan 2001 12:32:48 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: frowand@mvista.com
cc: Dan Malek <dan@mvista.com>, Jeff Hartmann <jhartmann@valinux.com>,
        michdaen@iiic.ethz.ch,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
In-Reply-To: <3A6CD180.EDFEA254@mvista.com>
Message-ID: <Pine.GSO.4.10.10101231226390.21679-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Mon, 22 Jan 2001, Frank Rowand wrote:

> Currently, my biggest user of this method is pci_alloc_consistent().  This use is
> because the 405 is not IO cache coherent.  In this case, the "physical" address
> is really a bus address, which pci_alloc_consistent calls "dma_handle".
> DMA-mapping.txt says drivers should not use bus_to_virt(), which is a close
> relative of phys_to_virt().

That's true, if you look into include/asm-sparc64/io.h, you see that
bus_to_virt()/virt_to_bus() are not defined anymore.

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
