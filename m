Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 47EA468A73
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Feb 2006 22:45:23 +1100 (EST)
Date: Thu, 2 Feb 2006 14:45:20 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: bharathi kandimalla <bharthik2004@yahoo.com>
Subject: Re: opening the serial port from userspace application
Message-ID: <20060202144520.3422129b@vitb.ru.mvista.com>
In-Reply-To: <20060201082419.53038.qmail@web50010.mail.yahoo.com>
References: <20060201082419.53038.qmail@web50010.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 1 Feb 2006 00:24:19 -0800 (PST)
bharathi kandimalla <bharthik2004@yahoo.com> wrote:

> Hi
> I am able to  use the serialport uart drivers  for the custom board with =
mpc860T=20
>  which are available in the kernel 2.6.13 =20
> I am getting bootup messages like this
>   ttyCPM0 at MMIO 0xfb000a80 (irq =3D 20) is a CPM UART
> ttyCPM1 at MMIO 0xfb000a90 (irq =3D 19) is a CPM UART
> ttyCPM2 at MMIO 0xfb000a00 (irq =3D 46) is a CPM UART
> ttyCPM3 at MMIO 0xfb000a20 (irq =3D 45) is a CPM UART =20

=46rom what I can see, you have misconfigured something. Dunno for certain, b=
ut 860T=20
might have 2 UARTs, when you have at least 4 enabled. Please enable in the =
kernel configuration only those which exist on your board.

>    And after getting prompt
> cd /proc/dev/    =20
> cat drivers
> /dev/tty             /dev/tty        5       0 system:/dev/tty
> /dev/console         /dev/console    5       1 system:console
> /dev/ptmx            /dev/ptmx       5       2 system
> ttyCPM               /dev/ttyCPM   204 46-49 serial
> pty_slave            /dev/pts      136 0-1048575 pty:slave
> pty_master           /dev/ptm      128 0-1048575 pty:master=20
>   I am  using mknod command=20
> mknod /dev/ttyCPM0 c 204 46=20
>     ln -sf  console ttyCPM0=20
> mknod /dev/ttyCPM1 c 204 47
> mknod /dev/ttyCPM2 c 204 48
> mknod /dev/ttyCPM3 c 204 49 =20
>   even I am not able to open the device from the user space application
>   I want to write some data from the user space into the
> application
> But I am not able to open the device
>   please help me out
> regards
> Bharathi=20
>                                                                 =20
>  =20
> =20
>=20
> 	=09
> ---------------------------------
> =20
>  What are the most popular cars? Find out at Yahoo! Autos=20


--=20
Sincerely,=20
Vitaly
