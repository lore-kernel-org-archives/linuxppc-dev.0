Return-Path: <jjboor@aimsys.nl>
In-Reply-To: <002001c52aef$d29dbb70$9c9c9182@ddns.htc.nl.philips.com>
References: <002001c52aef$d29dbb70$9c9c9182@ddns.htc.nl.philips.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <77bd0d4ff58c05c9207a1e401ccd13d5@aimsys.nl>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Date: Thu, 17 Mar 2005 13:57:56 +0100
To: "S. van Beek" <nlv11891@natlab.research.philips.com>
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

is there something printed before 'Now booting the kernel'?
If so, do the memory ranges not overlap or something?

Jaap-Jan

On 17-mrt-05, at 13:49, S. van Beek wrote:

> Hello there,
> =A0
> This is our first post on this list, hi all!
> We're two Dutch students working with a Virtex-II pro ff672 board from=20=

> Memec with the Communications 2 module. We've compiled a simple kernel=20=

> wich comes with MontaVista Linux=A03.1 (2.4.20) with ethernet and a=20
> serial port. It mounts its root filesystem over NFS and everything=20
> seems to work nicely. The next step we wanted to make was=20
> adding=A0support for the Flash=A0on the com board. We added the IP to =
the=20
> hardware and loaded the new bitstream in the FPGA. Next thing, we=20
> enabled support for MTD devices in the kernel. After that, the kernel=20=

> did not seem to boot anymore. It stopped at the message 'Now booting=20=

> the kernel'. So we read some documentation about debugging. We=20
> recompiled this kernel with the -g -ggdb options and removed the -O=20
> (optimalization) flag. Then we did not even see the ppc boot loader=20
> messages anymore when trying to boot. So we tried to compile the first=20=

> kernel (with only serial and ethernet support) -wich worked fine=20
> before-=A0with debugging and it gave us the same result.. no output at=20=

> all.
>  Can anyone give us some hints on what we can try more to find out=20
> what is going wrong?
>  =A0
> Regards,
> Sander van Beek
> Daniel van Os
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

J.G.J. Boor                       Anton Philipsweg 1
Software Engineer                 1223 KZ Hilversum
AimSys bv                         tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   mailto:jjboor@aimsys.nl
