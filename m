Return-Path: <intermediadc@hotmail.com>
Received: from DUB004-OMC3S1.hotmail.com (dub004-omc3s1.hotmail.com
 [157.55.2.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQdDC0GQ6zDqWl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 17:07:06 +1100 (AEDT)
Message-ID: <DUB406-EAS40731FD5A50A1D13A488E15C88B0@phx.gbl>
Content-Type: text/plain; charset="us-ascii"
Subject: Re: Freescale P5020 cpu will be kvm-pr?
References: <DUB117-W18044BE969CC05E69F545CC8BA0@phx.gbl>
 <1457482205.5360.114.camel@buserror.net>
 <DUB117-W1369999A718E6C0B33E4DC8C8B30@phx.gbl>
 <DUB117-W6931726DAC4EB1D528591DC8B40@phx.gbl>
 <1458081467.12370.31.camel@buserror.net>
 <DUB406-EAS2759FE0784777D029FB586BC88A0@phx.gbl>
 <1458186445.19333.3.camel@buserror.net>
From: luigi burdo <intermediadc@hotmail.com>
MIME-Version: 1.0 (1.0)
In-Reply-To: <1458186445.19333.3.camel@buserror.net>
Date: Thu, 17 Mar 2016 07:07:00 +0100
To: Scott Wood <oss@buserror.net>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "matthew@a-eon.com" <matthew@a-eon.com>, Trevor Dickinson
 <contact@a-eon.com>, Christian Zigotzky <chzigotzky@xenosoft.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hi scott,
i will send the logs for sure will be more understendable compared my=20
self learned english.


> Il giorno 17 mar 2016, alle ore 04:47, Scott Wood <oss@buserror.net> ha sc=
ritto:
>=20
>> On Wed, 2016-03-16 at 07:24 +0100, luigi burdo wrote:
>> hi Scott,
>> the P5020 mmu is signed by the kernel no book3e found
>=20
> I don't understand this sentence.
>=20

i have this in the dmesg no mmu book3e found  will write the exact message t=
oo.
>> kvm ppc64 crash if run by qemu.
>=20
> You didn't show that log.
>=20

i will seend it too

>> in the kernel( 4.5 too)all is enabled we had a base .config by freescale/=
nix
>> where kvm options and book3e  where enabled.
>=20
> You should start with corenet64_smp_defconfig, and enable KVM options plus=

> PPC_QEMU_E500.
>=20
yes it is enabled in the kernel config but  i have a exit with crash
>> my suspect is this can be an generated issue by  the host uboot
>=20
> Host U-Boot has nothing to do with KVM.
>=20
good to know, i had this suspect only because we have to force the booting w=
ith mem=3D3500M the uboot is a 2014 version.

>> or a missed tdb parameter and not a linux kernel problem.
>=20
> What is tdb?
>=20
sorry ipad bad typing tdb is the 5020.dtb=20
> -Scott
>=20
thanks for your time
luigi

Inviato da iPad
