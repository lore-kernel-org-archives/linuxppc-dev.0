Return-Path: <pengxihan@gmail.com>
Received: from mail-pw0-f43.google.com (mail-pw0-f43.google.com
	[209.85.160.43]) by ozlabs.org (Postfix) with ESMTP id 7B584B7BE5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Dec 2009 18:12:09 +1100 (EST)
Received: by pwi13 with SMTP id 13so423646pwi.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 07 Dec 2009 23:12:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8148211e0912071825t22ffa590va2fe22272f6aaf62@mail.gmail.com>
References: <8148211e0912061953n59dfbe4fsea033494ad8b6fcc@mail.gmail.com>
	<20091207180511.GA8914@loki.buserror.net>
	<8148211e0912071825t22ffa590va2fe22272f6aaf62@mail.gmail.com>
Date: Tue, 8 Dec 2009 15:12:07 +0800
Message-ID: <389deec70912072312i59aa431fi87b79ac64cca9ecc@mail.gmail.com>
Subject: Re: Ping does not work on my MPC8544 board, using linux2.6.23
From: hank peng <pengxihan@gmail.com>
To: =?UTF-8?B?5p6X5b+X5bmz?= <solyn123@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2009/12/8 =E6=9E=97=E5=BF=97=E5=B9=B3 <solyn123@gmail.com>:
>
> 2009/12/8 Scott Wood <scottwood@freescale.com>
>>
>> On Mon, Dec 07, 2009 at 11:53:22AM +0800, =E6=9E=97=E5=BF=97=E5=B9=B3 wr=
ote:
>> > Does dtc1.2.0 can compile dts files under linux2.6.23?
>>
>> Probably not -- 2.6.23 is very old, and I think newer dtcs only support
>> the
>> newer dts syntax.
>>
>> > Another question is that I found linux2.6.31 does not support
>> > board mpc8544ds,
>>
>> It should. =C2=A0What problems do you see?
>
> =3D> bootm 0x1000000 0x1800000 0x800000
> ## Booting kernel from Legacy Image at 01000000 ...
> =C2=A0=C2=A0 Image Name:=C2=A0=C2=A0 Linux-2.6.31
> =C2=A0=C2=A0 Image Type:=C2=A0=C2=A0 PowerPC Linux Kernel Image (gzip com=
pressed)
> =C2=A0=C2=A0 Data Size:=C2=A0=C2=A0=C2=A0 2185099 Bytes =3D=C2=A0 2.1 MB
> =C2=A0=C2=A0 Load Address: 00000000
> =C2=A0=C2=A0 Entry Point:=C2=A0 00000000
> =C2=A0=C2=A0 Verifying Checksum ... OK
> ## Loading init Ramdisk from Legacy Image at 01800000 ...
> =C2=A0=C2=A0 Image Name:=C2=A0=C2=A0 Simple Embedded Linux Framework
> =C2=A0=C2=A0 Image Type:=C2=A0=C2=A0 PowerPC Linux RAMDisk Image (gzip co=
mpressed)
> =C2=A0=C2=A0 Data Size:=C2=A0=C2=A0=C2=A0 1859256 Bytes =3D=C2=A0 1.8 MB
> =C2=A0=C2=A0 Load Address: 00000000
> =C2=A0=C2=A0 Entry Point:=C2=A0 00000000
> =C2=A0=C2=A0 Verifying Checksum ... OK
> ## Flattened Device Tree blob at 00800000
> =C2=A0=C2=A0 Booting using the fdt blob at 0x800000
> =C2=A0=C2=A0 Uncompressing Kernel Image ... OK
> =C2=A0=C2=A0 Loading Ramdisk to 1fca7000, end 1fe6ceb8 ... OK
> booting kernel using flat tree
> It then stops and never print any more,=C2=A0 I use mpc85xx_defconfig, I =
select
> mpc85xxds in the menuconfig and deselect other options like mpc8540ads et=
c.
>>
Try to change "link_address=3D'0x400000'" tp "link_address=3D'0x800000'"
in arch/powerpc/boot/wrapper.
If you have result, remember to give me a feedback.


>> > And I never boot linux-2.6.31 on my board, why linux-2.6.31 doesnot
>> > provide a config file like mpc8544_ds_defconfig?
>>
>> Does mpc85xx_defconfig not work?
>
> Yes mcp85xx_defconfig does not work, I can see mpc8540ads in the menuconf=
ig,
> but no mpc8544ds. And when I down load the generated uImage, It does not
> work.
>
>>
>> -Scott
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
The simplest is not all best but the best is surely the simplest!
