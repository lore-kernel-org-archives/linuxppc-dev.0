Return-Path: <tony.p.lee@gmail.com>
Message-ID: <470b63970504180952587057aa@mail.gmail.com>
Date: Mon, 18 Apr 2005 09:52:50 -0700
From: Tony Lee <tony.p.lee@gmail.com>
To: Peter Ryser <Peter.Ryser@xilinx.com>
In-Reply-To: <4239C6AE.3050803@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <002001c52aef$d29dbb70$9c9c9182@ddns.htc.nl.philips.com>
	<4239A41E.7040200@xilinx.com>
	<001501c52b0a$0ee36ca0$9c9c9182@ddns.htc.nl.philips.com>
	<4239C6AE.3050803@xilinx.com>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: Problems with MontaVista Linux on a Memec Virtex-II pro ff672
	board
Reply-To: Tony Lee <tony.p.lee@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Peter,=20

Maybe xilinx can come up with app note on how to debug the kernel=20
bring up / hanging issue with chipscope on PLB bus.

That would be the most powerful way to demo how to use the=20
Xilinx VP HW platform to debug some tricky kernel issues.
You have a extreme flexible platform for this.  We just need a
xilinx's guiding hand from time to time.


I can use the same help too for following issues with linux on VP 20.  :-) =
=20

   * I have trouble finding where 700+ msec cpu time went in my
currect system - kernel, ISR, other user tasks.

   * Sometime on power on, the linux would lockup before everything is read=
y.


-Tony


On 3/17/05, Peter Ryser <Peter.Ryser@xilinx.com> wrote:
> Also try to boot the first Linux kernel (the one without the Flash
> support) on the EDK design with Flash support. It will help narrow down
> the problem to the HW or the SW.
>=20
> - Peter
>=20
> S. van Beek wrote:
>=20
> >>How did you add the Flash (EMC) peripheral? Did you use the Base System
> >>Builder to generate your hardware?
> >>
> >>
> >
> >Yes, we started a new project using the base system builder with the sam=
e
> >options as the previous (working) project and flash, so the address rang=
e
> >should be ok. I'll check tomorrow, right now its time to go home ;)
> >
> >Regards,
> >Sander
> >
> >----- Original Message -----
> >From: "Peter Ryser" <Peter.Ryser@xilinx.com>
> >To: "S. van Beek" <nlv11891@prle>
> >Cc: <Linuxppc-embedded@ozlabs.org>
> >Sent: Thursday 17 March 2005 16:37
> >Subject: Re: Problems with MontaVista Linux on a Memec Virtex-II pro ff6=
72
> >board
> >
> >
> >
> >
> >>How did you add the Flash (EMC) peripheral? Did you use the Base System
> >>Builder to generate your hardware?
> >>
> >>If you configure the hardware manually and use the OPB EMC make sure
> >>that you add the address range to the PLB2OPB bridge.
> >>
> >>- Peter
> >>
> >>
> >>S. van Beek wrote:
> >>
> >>
> >>
> >>>Hello there,
> >>>
> >>>This is our first post on this list, hi all!
> >>>We're two Dutch students working with a Virtex-II pro ff672 board from
> >>>Memec with the Communications 2 module. We've compiled a simple kernel
> >>>wich comes with MontaVista Linux 3.1 (2.4.20) with ethernet and a
> >>>serial port. It mounts its root filesystem over NFS and everything
> >>>seems to work nicely. The next step we wanted to make was
> >>>adding support for the Flash on the com board. We added the IP to the
> >>>hardware and loaded the new bitstream in the FPGA. Next thing, we
> >>>enabled support for MTD devices in the kernel. After that, the kernel
> >>>did not seem to boot anymore. It stopped at the message 'Now booting
> >>>the kernel'. So we read some documentation about debugging. We
> >>>recompiled this kernel with the -g -ggdb options and removed the -O
> >>>(optimalization) flag. Then we did not even see the ppc boot loader
> >>>messages anymore when trying to boot. So we tried to compile the first
> >>>kernel (with only serial and ethernet support) -wich worked fine
> >>>before- with debugging and it gave us the same result.. no output at
> >>>
> >>>
> >all.
> >
> >
> >>>Can anyone give us some hints on what we can try more to find out what
> >>>is going wrong?
> >>>
> >>>Regards,
> >>>Sander van Beek
> >>>Daniel van Os
> >>>
> >>>----------------------------------------------------------------------=
--
> >>>
> >>>_______________________________________________
> >>>Linuxppc-embedded mailing list
> >>>Linuxppc-embedded@ozlabs.org
> >>>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >>>
> >>>
> >>>
> >>
> >>
> >>
> >
> >
> >
> >
> >
> >
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20


--=20
-Tony
Having fun with FPGA HW + ppc + Linux
