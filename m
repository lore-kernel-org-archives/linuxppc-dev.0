Message-ID: <3A6CBE77.4D81B65@mvista.com>
Date: Mon, 22 Jan 2001 15:12:55 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Roman Zippel <zippel@fh-brandenburg.de>
CC: Jeff Hartmann <jhartmann@valinux.com>, Dan Malek <dan@mvista.com>,
        michdaen@iiic.ethz.ch,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <Pine.GSO.4.10.10101222206430.24677-100000@zeus.fh-brandenburg.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Roman Zippel wrote:
>
> Hi,
>
> On Mon, 22 Jan 2001, Jeff Hartmann wrote:
>

>
> ppc doesn't have page table, it either uses a hash table or the tlb
> entries have to be filled by software. Anyway, pgd/pmd/pte are used to
> keep the management compatible to Linux and are like ia32 also two levels.

The 4xx implementation does have a page table (and doesn't have a hash table).

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
