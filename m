Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FA8C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 18:16:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B47272087A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 18:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47272087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kN844F1qzF1BS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 05:16:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kN5F69W1zF14t
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 05:13:37 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42kN583SBRz9ttC2;
 Mon, 29 Oct 2018 19:13:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id tRPJ2G20J5MY; Mon, 29 Oct 2018 19:13:32 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42kN582pH2z9ttBn;
 Mon, 29 Oct 2018 19:13:32 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id 93123631; Mon, 29 Oct 2018 19:13:21 +0100 (CET)
Received: from 37.165.163.231 ([37.165.163.231]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Mon, 29 Oct 2018 19:13:21 +0100
Date: Mon, 29 Oct 2018 19:13:21 +0100
Message-ID: <20181029191321.Horde.fxo4MJUhTstCq8zaw1lK7Q3@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: NXP P50XX/e5500: SMP doesn't work anymore with the latest Git
 kernel
References: <6bcb4b23-bb78-d1a5-7fd0-5f892115d302@xenosoft.de>
 <99266ac6-640c-b2a9-eef3-4e89ee1e0ad5@xenosoft.de>
 <f6ca1728-d312-1267-d9d7-18d2369f1bf7@xenosoft.de>
In-Reply-To: <f6ca1728-d312-1267-d9d7-18d2369f1bf7@xenosoft.de>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christian Zigotzky <chzigotzky@xenosoft.de> a =C3=A9crit=C2=A0:

> Hello,
>
> I figured out that the problem is in the OF source code of the=20=20
>=20commit: Merge tag devicetree-for-4.20. [1]

That's a merge commit. Can you bisect the branch and identify the=20=20
faulting=20commit ?

Christophe

>
> I reverted the following OF files and SMP works!
>
> drivers/of/base.c
> drivers/of/device.c
> drivers/of/of_mdio.c
> drivers/of/of_numa.c
> drivers/of/of_private.h
> drivers/of/overlay.c
> drivers/of/platform.c
> drivers/of/unittest-data/overlay_15.dts
> drivers/of/unittest-data/tests-overlay.dtsi
> drivers/of/unittest.c
> include/linux/of.h
>
> Cheers,
> Christian
>
> [1]=20=20
>=20https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Db27186abb37b7bd19e0ca434f4f425c807dbd708
>
>
> On 29 October 2018 at 10:56AM, Christian Zigotzky wrote:
>> Hello,
>>
>> I have figured out that the commit 'devicetree-for-4.20' [1] is=20=20
>>=20responsible for the SMP problem. I was able to revert this commit=20=
=20
>>=20with 'git revert b27186abb37b7bd19e0ca434f4f425c807dbd708 -m 1'=20=20
>>=20today.
>>
>> [master ec81438] Revert "Merge tag 'devicetree-for-4.20' of=20=20
>>=20git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux"
>> 138 files changed, 931 insertions(+), 1538 deletions(-)
>> rename Documentation/devicetree/bindings/arm/{atmel-sysregs.txt =3D>=20=
=20
>>=20atmel-at91.txt} (67%)
>> delete mode 100644=20=20
>>=20Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.tx=
t
>> delete mode 100644=20=20
>>=20Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.tx=
t
>> rename Documentation/devicetree/bindings/arm/{zte,sysctrl.txt =3D>=20=20
>>=20zte.txt} (62%)
>> delete mode 100644 Documentation/devicetree/bindings/misc/lwn-bk4.txt
>> create mode 100644 arch/c6x/boot/dts/linked_dtb.S
>> delete mode 100644 arch/nios2/boot/dts/Makefile
>> create mode 100644 arch/nios2/boot/linked_dtb.S
>> delete mode 100644 arch/powerpc/boot/dts/Makefile
>> delete mode 100644 arch/powerpc/boot/dts/fsl/Makefile
>> delete mode 100644 scripts/dtc/yamltree.c
>>
>> It solves the SMP problem! SMP works again on my P5020 board and on=20=
=20
>>=20virtual e5500 QEMU machines.
>>
>> QEMU command: ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048=20=20
>>=20-kernel /home/christian/Downloads/uImage-4.20-alpha5 -drive=20=20
>>=20format=3Draw,file=3D/home/christian/Dokumente/ubuntu_MATE_16.04.3_LTS_=
PowerPC_QEMU/ubuntu_MATE_16.04_PowerPC.img,index=3D0,if=3Dvirtio -nic user,=
model=3De1000 -append "rw root=3D/dev/vda3" -device virtio-vga -device virt=
io-mouse-pci -device virtio-keyboard-pci -soundhw es1370 -smp=20=20
>>=204
>>
>> Screenshot:=20=20
>>=20https://plus.google.com/u/0/photos/photo/115515624056477014971/6617705=
776207990082
>>
>> Do we need a new dtb file or is it a bug?
>>
>> Thanks,
>> Christian
>>
>> [1]=20=20
>>=20https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3Db27186abb37b7bd19e0ca434f4f425c807dbd708
>>
>>
>> On 28 October 2018 at 5:35PM, Christian Zigotzky wrote:
>>> Hello,
>>>
>>> SMP doesn't work anymore with the latest Git kernel (28/10/18=20=20
>>>=2011:12AM GMT) on my P5020 board and on virtual e5500 QEMU machines.
>>>
>>> Board with P5020 dual core CPU:
>>>
>>> [=C2=A0=C2=A0=C2=A0 0.000000] -----------------------------------------=
------------
>>> [=C2=A0=C2=A0=C2=A0 0.000000] phys_mem_size=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 0x200000000
>>> [=C2=A0=C2=A0=C2=A0 0.000000] dcache_bsize=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D 0x40
>>> [=C2=A0=C2=A0=C2=A0 0.000000] icache_bsize=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D 0x40
>>> [=C2=A0=C2=A0=C2=A0 0.000000] cpu_features=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D 0x00000003008003b4
>>> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 possible=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D 0x00000003009003b4
>>> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 always=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x00000003008003b4
>>> [=C2=A0=C2=A0=C2=A0 0.000000] cpu_user_features =3D 0xcc008000 0x080000=
00
>>> [=C2=A0=C2=A0=C2=A0 0.000000] mmu_features=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D 0x000a0010
>>> [=C2=A0=C2=A0=C2=A0 0.000000] firmware_features =3D 0x0000000000000000
>>> [=C2=A0=C2=A0=C2=A0 0.000000] -----------------------------------------=
------------
>>> [=C2=A0=C2=A0=C2=A0 0.000000] CoreNet Generic board
>>>
>>> =C2=A0=C2=A0=C2=A0 ...
>>>
>>> [=C2=A0=C2=A0=C2=A0 0.002161] smp: Bringing up secondary CPUs ...
>>> [=C2=A0=C2=A0=C2=A0 0.002339] No cpu-release-addr for cpu 1
>>> [=C2=A0=C2=A0=C2=A0 0.002347] smp: failed starting cpu 1 (rc -2)
>>> [=C2=A0=C2=A0=C2=A0 0.002401] smp: Brought up 1 node, 1 CPU
>>>
>>> Virtual e5500 quad core QEMU machine:
>>>
>>> [=C2=A0=C2=A0=C2=A0 0.026394] smp: Bringing up secondary CPUs ...
>>> [=C2=A0=C2=A0=C2=A0 0.027831] No cpu-release-addr for cpu 1
>>> [=C2=A0=C2=A0=C2=A0 0.027989] smp: failed starting cpu 1 (rc -2)
>>> [=C2=A0=C2=A0=C2=A0 0.030143] No cpu-release-addr for cpu 2
>>> [=C2=A0=C2=A0=C2=A0 0.030304] smp: failed starting cpu 2 (rc -2)
>>> [=C2=A0=C2=A0=C2=A0 0.032400] No cpu-release-addr for cpu 3
>>> [=C2=A0=C2=A0=C2=A0 0.032533] smp: failed starting cpu 3 (rc -2)
>>> [=C2=A0=C2=A0=C2=A0 0.033117] smp: Brought up 1 node, 1 CPU
>>>
>>> QEMU command: ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048=20=20
>>>=20-kernel=20=20
>>>=20/home/christian/Downloads/vmlinux-4.20-alpha4-AmigaOne_X1000_X5000/X5=
000_and_QEMU_e5500/uImage-4.20 -drive format=3Draw,file=3D/home/christian/D=
ownloads/MATE_PowerPC_Remix_2017_0.9.img,index=3D0,if=3Dvirtio -nic user,mo=
del=3De1000 -append "rw root=3D/dev/vda" -device virtio-vga -device virtio-=
mouse-pci -device virtio-keyboard-pci -usb -soundhw es1370 -smp=20=20
>>>=204
>>>
>>> .config:
>>>
>>> ...
>>> CONFIG_SMP=3Dy
>>> CONFIG_NR_CPUS=3D4
>>> ...
>>>
>>> Please test the latest Git kernel on your NXP P50XX boards.
>>>
>>> Thanks,
>>> Christian
>>>
>>
>>


