Date: Wed, 7 Feb 2001 19:39:23 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Dan Malek <dan@mvista.com>
cc: paulus@linuxcare.com.au, Gabriel Paubert <paubert@iram.es>,
        tom_gall@vnet.ibm.com, linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
In-Reply-To: <3A8189F1.8E6AA8C2@mvista.com>
Message-ID: <Pine.GSO.4.10.10102071921140.14928-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Wed, 7 Feb 2001, Dan Malek wrote:

> > Somewhere I lost you, could you explain it a bit more (maybe with an
> > example)? What has CONFIG_HIGHMEM to do with the pci mapping???
>
> The only thing they have in common is the desire to consume kernel
> virtual space.  They were just two examples of the reason I am trying
> to find methods of increasing the kernel virtual space.

CONFIG_HIGHMEM has little to do with the kernel virtual space. The main
purpose is to get the memory into user space, where user programs can use
them. I really don't understand, what problem you're trying to solve. The
kernel only wants to manage high memory and rarely access it (and uses
kmap for this), most of the time these pages should be in the user virtual
address space only.

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
