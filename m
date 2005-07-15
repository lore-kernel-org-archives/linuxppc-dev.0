Return-Path: <sipcop009@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.195])
	by ozlabs.org (Postfix) with ESMTP id BEE6167C44
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Jul 2005 00:14:34 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id m22so348892nzf
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Jul 2005 07:14:33 -0700 (PDT)
Message-ID: <5a4792c00507150714243238da@mail.gmail.com>
Date: Fri, 15 Jul 2005 07:14:32 -0700
From: SIP COP 009 <sipcop009@gmail.com>
To: Allen Curtis <acurtis@onz.com>
In-Reply-To: <ef81e8ced15bf8004ec0cd927d7cff8e@onz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5a4792c0050713235574522cfb@mail.gmail.com>
	<E65A8A95-7352-40A3-9A86-EF437F0132D0@freescale.com>
	<5a4792c0050714120571fff071@mail.gmail.com>
	<ef81e8ced15bf8004ec0cd927d7cff8e@onz.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 8272ADS and Linux 2.6.12
Reply-To: SIP COP 009 <sipcop009@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Here's my serial config..., also these dont show up if i just=20
run "make ads8272_defconfig". I have to explicitly go and enable the
serial options.


#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
CONFIG_SERIAL_8250_NR_UARTS=3D4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
# CONFIG_SERIAL_CPM is not set
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=3Dy
CONFIG_LEGACY_PTYS=3Dy
CONFIG_LEGACY_PTY_COUNT=3D256

Thanks!
ashutosh

On 7/14/05, Allen Curtis <acurtis@onz.com> wrote:
> > =3D> setenv bootargs console=3DttyCPM0,115200  root=3D/dev/ram
> > =3D> bootm fe600000
> > ## Booting image at fe600000 ...
> >    Image Name:   2.6.12 for 8272
> >    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> >    Data Size:    875845 Bytes =3D 855.3 kB
> >    Load Address: 00000000
> >    Entry Point:  00000000
> >    Verifying Checksum ... OK
> >    Uncompressing Kernel Image ... OK
> >
>=20
> Can you provide your kernel configuration information regarding the
> serial ports. Which serial port is your console port? Check the
> following configuration options:
>   CONFIG_SERIAL_CONSOLE
>   CONFIG_SCC_CONSOLE
>   CONFIG_SERIAL_CORE
>   CONFIG_SERIAL_CORE_CONSOLE
>=20
> Another observation is that you are trying to boot with a RAM disk but
> you have not provided the RAM disk address to the bootm command. This
> is not your current problem since you don't get that far.
>=20
> - Allen
>=20
>
