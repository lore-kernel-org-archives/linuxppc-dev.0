Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id E38D2DDE24
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 17:04:26 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JtHDq-0004n8-Pi
	for linuxppc-dev@ozlabs.org; Tue, 06 May 2008 00:04:22 -0700
Message-ID: <17077099.post@talk.nabble.com>
Date: Tue, 6 May 2008 00:04:22 -0700 (PDT)
From: wangyanlong <killyouatonce@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Fwd: linux2.6 does not boot from XUP
In-Reply-To: <2c8360dd0805051732v64966f4ej7ded735519c63f65@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <2c8360dd0805051732v64966f4ej7ded735519c63f65@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi ,boys . I am in the XiDian universtiy of china . I am doing the things i=
ke
yours.You can try set ttyUL0,if you use the Uartlite. If it don't work , ma=
y
be  gcc 4.1.0  miscompile the kernel 2.6 , I am using the gcc3.4.4.
Good luck
=20

=E5=BC=A0=E8=BD=B6 wrote:
>=20
> ---------- Forwarded message ----------
> From: =E5=BC=A0=E8=BD=B6 <zhangyihere@gmail.com>
> Date: 2008/5/5
> Subject: linux2.6 does not boot from XUP
> To: grant.likely@secretlab.ca
>=20
>=20
> Hi,Grant
>=20
> I hope I could get some advices from you about how to fix the error of
> porting linux2.6 to Xilinx XUPV2P.
>=20
> The kernel I am using is 2.6.24,gcc 4.1.0,glibc 2.3.6,and the board Xilin=
x
> XUPV2P
>=20
> It compiles successfully with some warnings like below:
>   MODPOST vmlinux.o
> WARNING: vmlinux.o(.text+0x223c): Section mismatch: reference to
> .init.text:early_init (between 'start_here' and 'initial_mmu')
> WARNING: vmlinux.o(.text+0x2254): Section mismatch: reference to
> .init.text:machine_init (between 'start_here' and 'initial_mmu')
> WARNING: vmlinux.o(.text+0x2258): Section mismatch: reference to
> .init.text:MMU_init (between 'start_here' and 'initial_mmu')
> WARNING: vmlinux.o(.text+0x22b2): Section mismatch: reference to
> .init.text:start_kernel (between 'start_here' and 'initial_mmu')
> WARNING: vmlinux.o(.text+0x22b6): Section mismatch: reference to
> .init.text:start_kernel (between 'start_here' and 'initial_mmu')
>    LD      vmlinux
>=20
> The system is created as ACE file and booted from CF Card
>=20
> After uncompressing the kernel,the system hangs.The information is like
> below:
>=20
> loaded at:     00400000 0056619C
> board data at: 00000000 0000007C
> relocated to:  00404068 004040E4
> zimage at:     00404E51 00563BF4
> avail ram:     00567000 7C9E2370
>=20
> Linux/PPC load: console=3DttyS0,9600 root=3D/dev/xsysace/disc0/part3 rw
> Uncompressing Linux...done.
> Now booting the kernel
> I wonder if it is the upper WARNINGs that causes the hang of the system,
> and
> how can I fix it.
>=20
> Thanks in advance, any advice would be helpful
>=20
> Best Regards
>=20
> Yi
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20

--=20
View this message in context: http://www.nabble.com/Fwd%3A-linux2.6-does-no=
t-boot-from-XUP-tp17074762p17077099.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
