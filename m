Date: Thu, 12 Oct 2000 13:28:22 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Xavier Grave <grave@ipno.in2p3.fr>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4 kernel doesn't allocate resource for my PCI Board 
In-Reply-To: <Pine.LNX.4.21.0010121107090.10161-100000@ipnpcu5>
Message-ID: <Pine.LNX.4.10.10010121326370.373-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 12 Oct 2000, Xavier Grave wrote:
> I'm new to this list. I'm working on a VME Board from motorolla
> (MVME2303) and I have a 2.2.17 kernel running without problem.
>
> The board have a Pci Mezzanine Card with a NCR 53c895 chip for my SCSI
> disk. When I try to boot the latest kernel (I'm trying from 2.4.0-test6 up
> to 2.4.0-test10) I have the following error message during boot :
>
> PCI: Cannot allocate resource region 1 of device 00:11.0
> PCI: Cannot allocate resource region 2 of device 00:11.0
> PCI: Failed to allocate resource 2 for Symbios Logic Inc. (formerly
> NCR) 53c895

I assume you are using kernels from ftp.*.kernel.org? These don't have calls
to pci_read_bridge_bases() in any of the PPC specific files.

This is fixed for at least some machines (G4?) in the BitKeeper tree. For
MVME, someone with the hardware needs to take a look, I guess.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
