Date: Wed, 7 Feb 2001 10:18:46 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Dan Malek <dan@mvista.com>
cc: paulus@linuxcare.com.au, Gabriel Paubert <paubert@iram.es>,
        tom_gall@vnet.ibm.com, linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
In-Reply-To: <3A806D89.16B31EA0@mvista.com>
Message-ID: <Pine.GSO.4.10.10102071016080.23505-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Tue, 6 Feb 2001, Dan Malek wrote:

> We are currently using VSIDs as a lazy TLB reloader, not for
> a large VM space context manager.  There shouldn't be any need
> for CONFIG_HIGHMEM on PowerPC, and we should be able to map huge
> PCI spaces we see on the multiple bridge CPCI systems without
> any worry of running out of VM space.

Somewhere I lost you, could you explain it a bit more (maybe with an
example)? What has CONFIG_HIGHMEM to do with the pci mapping???

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
