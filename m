Message-ID: <3AAFCF65.CAC8E623@mvista.com>
Date: Wed, 14 Mar 2001 12:07:01 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: "Curry, Diane" <dcurry@infiniswitch.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IDE interface driver on the 405gp
References: <FF6CF34C346E724596A2FB5CAAB2C49707F906@voyager.ops.infiniswitch.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Curry, Diane" wrote:
>
> Hello -
>   I'm running an IBM 405GP rev D walnut and Monta Vista's 2.4.2 port.  I
> have a
> PCI-to-PCMCIA adapter, a PCMCIA card reader/writer and an IBM
> Microdrive.  I've
> got a root filesystem on the Microdrive and a kernel image built with an
> initial ram disk.
> The kernel boots with the initrd image, my linuxrc scripts loads the
> pcmcia modules and
> switches roots to the microdrive.  This is all working fine, but I'm
> questioning what I did
> to get it working (it seemed too easy).  All of the changes, except some
> endian issues
> which I addressed in the pcmcia i82365.c module, were to ppc4xx_setup.c.
> Essentially
> all I did was initialize the ppc_ide_md structure with function names
> and provide the
> corresponding functions (using m8xx_setup.c as a reference).  If anyone
> could tell me
> whether this seems reasonable, I'd really appreciate it.  Thanks  in
> advance.
>
> Diane Curry
> dcurry@Infiniswitch.com

Sounds reasonable.

Which PCI-to-PCMCIA adapter are you using?  (Can you cat /proc/pci or
do a lspci -v?)

I meant to include this stuff in the latest kernel, but forget to.  It
will be in the next version.

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
