Return-Path: <nlv11891@natlab.research.philips.com>
Message-ID: <001501c52b0a$0ee36ca0$9c9c9182@ddns.htc.nl.philips.com>
From: "S. van Beek" <nlv11891@natlab.research.philips.com>
To: "Peter Ryser" <Peter.Ryser@xilinx.com>,
	"S. van Beek" <nlv11891@natlab.research.philips.com>
References: <002001c52aef$d29dbb70$9c9c9182@ddns.htc.nl.philips.com>
	<4239A41E.7040200@xilinx.com>
Date: Thu, 17 Mar 2005 16:57:44 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: Problems with MontaVista Linux on a Memec Virtex-II pro ff672
	board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> How did you add the Flash (EMC) peripheral? Did you use the Base System
> Builder to generate your hardware?

Yes, we started a new project using the base system builder with the same
options as the previous (working) project and flash, so the address range
should be ok. I'll check tomorrow, right now its time to go home ;)

Regards,
Sander

----- Original Message ----- 
From: "Peter Ryser" <Peter.Ryser@xilinx.com>
To: "S. van Beek" <nlv11891@prle>
Cc: <Linuxppc-embedded@ozlabs.org>
Sent: Thursday 17 March 2005 16:37
Subject: Re: Problems with MontaVista Linux on a Memec Virtex-II pro ff672
board


> How did you add the Flash (EMC) peripheral? Did you use the Base System
> Builder to generate your hardware?
>
> If you configure the hardware manually and use the OPB EMC make sure
> that you add the address range to the PLB2OPB bridge.
>
> - Peter
>
>
> S. van Beek wrote:
>
> > Hello there,
> >
> > This is our first post on this list, hi all!
> > We're two Dutch students working with a Virtex-II pro ff672 board from
> > Memec with the Communications 2 module. We've compiled a simple kernel
> > wich comes with MontaVista Linux 3.1 (2.4.20) with ethernet and a
> > serial port. It mounts its root filesystem over NFS and everything
> > seems to work nicely. The next step we wanted to make was
> > adding support for the Flash on the com board. We added the IP to the
> > hardware and loaded the new bitstream in the FPGA. Next thing, we
> > enabled support for MTD devices in the kernel. After that, the kernel
> > did not seem to boot anymore. It stopped at the message 'Now booting
> > the kernel'. So we read some documentation about debugging. We
> > recompiled this kernel with the -g -ggdb options and removed the -O
> > (optimalization) flag. Then we did not even see the ppc boot loader
> > messages anymore when trying to boot. So we tried to compile the first
> > kernel (with only serial and ethernet support) -wich worked fine
> > before- with debugging and it gave us the same result.. no output at
all.
> > Can anyone give us some hints on what we can try more to find out what
> > is going wrong?
> >
> > Regards,
> > Sander van Beek
> > Daniel van Os
> >
> >------------------------------------------------------------------------
> >
> >_______________________________________________
> >Linuxppc-embedded mailing list
> >Linuxppc-embedded@ozlabs.org
> >https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
>
>
>
