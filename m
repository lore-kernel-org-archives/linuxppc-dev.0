Date: Mon, 22 Jan 2001 20:28:21 -0600
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Dan Malek <dan@mvista.com>, Roman Zippel <zippel@fh-brandenburg.de>
CC: Jeff Hartmann <jhartmann@valinux.com>, <michdaen@iiic.ethz.ch>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Gareth Hughes <gareth@valinux.com>, <linuxppc-dev@lists.linuxppc.org>,
        <dri-devel@lists.sourceforge.net>,
        Paul Mackerras <paulus@linuxcare.com>
Message-ID: <B6924864.5CF1%toe@unlserve.unl.edu>
In-Reply-To: <3A6CCF31.C44706E2@mvista.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 1/22/01 6:24 PM, Dan Malek wrote:

> The PowerPC port, except for a couple of processors (4xx and 8xx again)
> could never use virt_to_phys on any dynamically allocated (vmalloc()'ed)
> space.  All of the drivers/devices that used these macros were using
> ioremapped() or static buffers.  Perhaps the PCI mapping functions are
> implementing some of this, and I need to take a look.

Is it really true that virt_to_phys on vmalloc'd memory is broken 6xx?  I
wonder why planb works at all....


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
