Date: Mon, 13 Aug 2001 21:45:46 -0700 (PDT)
From: James F Dougherty <jfd@GigabitNetworks.COM>
Message-Id: <200108140445.VAA05340@krakatoa.gigabitnetworks.com>
To: trini@kernel.crashing.org, jrp@wvi.com
Subject: Re: PCI IDE Adapter for PPC/Linux
Cc: jfd@GigabitNetworks.COM, mlocke@mvista.com, dmj+@andrew.cmu.edu,
	linuxppc-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


http://ppcboot.sourceforge.net/

Download PPCBoot

ppcboot/common/cmd_ide.c
ppcboot/include/ide.h
ppcboot/disk/*

>
>
> > > Also, how come it is not running in Native mode? Does anyone know what
> > > the changes are to the pdc driver to enable this?
> >
> > iirc, that means the BIOS didn't set it up, thats all.
>
> Hey, I've got an embedded PPC project in the works and this touches on it
> -- where can I find out what kind of boot rom setup I need to perform for
> the IDE adapter to work under Linux?
>
> --
> Sincerely,
>
> Jim Potter
> 45th Parallel Processing
> jrp@wvi.com
>
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
