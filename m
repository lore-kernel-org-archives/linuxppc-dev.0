Date: Thu, 12 Oct 2000 15:45:20 +0200 (CEST)
From: Xavier Grave <grave@ipno.in2p3.fr>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4 kernel doesn't allocate resource for my PCI Board 
In-Reply-To: <Pine.LNX.4.10.10010121326370.373-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.21.0010121543220.10161-100000@ipnpcu5>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 12 Oct 2000, Geert Uytterhoeven wrote:
> I assume you are using kernels from ftp.*.kernel.org? These don't have calls
> to pci_read_bridge_bases() in any of the PPC specific files.

I've tryed a few from ftp.kernel.org, but also with the kernel from
fsmlabs.com

xavier

33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
