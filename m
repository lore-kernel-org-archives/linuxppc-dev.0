Return-Path: <BlakesleeS@embeddedplanet.com>
Received: from embeddedplanet.com (unknown [66.94.95.194])
	by ozlabs.org (Postfix) with ESMTP id E8EDE2BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 00:55:47 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 12 Jan 2005 08:55:38 -0500
Message-ID: <1628E43D99629C46988BE46087A3FBB912F207@ep-01.EmbeddedPlanet.local>
From: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
To: "Vijay Padiyar" <vijay_padiyar@hotmail.com>,
	"LinuxPPC Support" <linuxppc-embedded@ozlabs.org>
Subject: RE: Some issues with kernel 2.6 for MPC8260 target
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I would suggest going to the latest 2.6.10 kernel.  I have it running
with several ethernets running on all the 82xx processors.=20

> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of=20
> Vijay Padiyar
> Sent: Wednesday, January 12, 2005 5:37 AM
> To: LinuxPPC Support
> Subject: Some issues with kernel 2.6 for MPC8260 target
>=20
> Hi all
>=20
> I wish to discuss some strange issues that I faced with=20
> respect to the Linux
> 2.6.8 kernel (downloaded from kernel.org). Firstly, I wish to=20
> know whether this has been known to work on an MPC8260 PowerPC target.
>=20
> Secondly, when I tried to compile the Linux kernel with my=20
> toolchain (built with Dan Kegel's crosstool for the PowerPC=20
> 603e core, which is what my processor has), I got some errors=20
> which I found to rather queer after investigation. Firstly,=20
> let me state the errors that I got:
>=20
> ------------------------------------------------------
>=20
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/ppc/8260_io/built-in.o(.text+0x103c): In function=20
> `mii_queue_relink':
> arch/ppc/8260_io/fcc_enet.c:1254: undefined reference to=20
> `schedule_task'
> arch/ppc/8260_io/built-in.o(.text+0x1074): In function=20
> `mii_queue_config':
> arch/ppc/8260_io/fcc_enet.c:1263: undefined reference to=20
> `schedule_task'
>=20
> ------------------------------------------------------
>=20
> On further investigation, I find that 'schedule_task()' is=20
> simply not defined anywhere in the 2.6.8 kernel sources. This=20
> is quite wierd! However, it is defined in a file 'context.c'=20
> (linux-src/kernel) in the 2.4.27 kernel sources, which we=20
> were using earlier. How is it that a function is being called=20
> but its definition has been removed from the sources?
>=20
> Another such example is with the structure 'tq_struct'. It is=20
> referred to in the file 'fcc_enet.c'=20
> (linux-src/arch/ppc/8260_io) but it's not defined anywhere!=20
> Again, after checking in the 2.4.27 sources, I find that it's=20
> defined in the file 'tqueue.h' (linux-src/include/linux)!
>=20
> A third thing is that the 2.4.27 kernel source file 'uart.c'
> (linux-src/arch/ppc/cpm2_io) is not present in the=20
> corresponding folder in the 2.6.8 source=20
> (linux-src/arch/ppc/8260_io). There is one 'uart.c' in the=20
> folder '8xx_io', but it doesn't get compiled during the=20
> kernel build process. Will my UART work correctly with this build?
>=20
> Can someone please tell me if there's some explanation for=20
> this that I'm unaware of? Which would be the proper forum to=20
> report this? Again I would like to ask: Has the 2.6.8 kernel=20
> been tested successfully on the MPC8260 PowerPC platform?
>=20
> Lastly, where can I get the latest stable Linux kernel source=20
> for the PowerPC platform?
>=20
> Regards
>=20
> Vijay Padiyar
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
