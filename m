Date: Fri, 29 Sep 2000 17:57:52 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Benjamin Herrenschmidt <bh40@calva.net>, Matt Porter <mmporter@home.com>,
        Olaf Hering <olh@suse.de>,
        Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
In-Reply-To: <Pine.LNX.4.10.10009281200120.3468-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.21.0009291748330.1713-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 28 Sep 2000, Geert Uytterhoeven wrote:

> > Don't expect it to initialize the S3 card in any case, the int10 module
> > needs ISA IO/mem accesses and both don't work at the moment for linux/ppc
> > you can imagine what the following code will do to your machine :(
> >
> >  #define V_RAM 0xA0000
> >  INTPriv(pInt)->vRam = xf86MapVidMem(screen,VIDMEM_MMIO,V_RAM,size);
>
> Yes, you have to know the ISA memory base address, which is machine dependent.

Thanks to Ben we have the pciconfig_iobase syscall now but nothing to get
the ISA memory base, if someone has the time to add such a syscall fixing
xf86MapVidMem shouldn't be hard at all.

  Kostas.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
