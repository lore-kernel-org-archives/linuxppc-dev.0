Return-Path: <Baohua.WANG@alcatel-sbell.com.cn>
Received: from mail.alcatel-sbell.com.cn (nat1.alcatel-sbell.com.cn
	[202.96.203.177]) by ozlabs.org (Postfix) with ESMTP id 9D5E867EB7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 18:57:57 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Date: Thu, 4 Aug 2005 16:57:12 +0800
Message-ID: <A9DE2BAF233E444FA9C5E77A5825A01E865053@ydmail.sbell.com.cn>
From: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
To: "Alex Zeffertt" <ajz@cambridgebroadband.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: ??:  PPC860 board and PPCBoot "verifying Checksum... Bad Data CRC"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Alex:
 I had set the mhz, but of no use. I debug the kernel log  found that it =
is halted on the mount_root()  of init/do_mounts.c
 What is happened in my kernel ? I have initrd include it when config =
the kernel.
=20
 =20

-----????-----
???: Alex Zeffertt [mailto:ajz@cambridgebroadband.com]
????: 2005?8?4? 16:32
???: FCG WANG Baohua
??: Re: =3D?ISO-8859-1?B??=3D PPC860 board and PPCBoot "verifying =
Checksum... Bad Data CRC"


This could be down to the clocks_in_mhz uboot environment variable.  Try =
doing this with
clocks_in_mhz=3D1, and again with this variable not defined.

Alex


On Wed, 3 Aug 2005 10:06:26 +0800
"FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn> wrote:

> Dear Alex :
>  =20
> The kernel is halted after printing "Transferring control to Linux (at =
address 00000000) ...".
>   I had read all the eldk FAQ and other charpter throughtly. I checked =
the IMMR_ADDR in kernel
>   2.4.25 and  memory map.They are all right. The UART configuration is =
also right. So I think the
>   FAQ cannot give me any help now. It is the kernel configuration that =
lead the kernel halt. So I
>   want to ask for a right kernel configuration for 8xx ADS board. My =
board type is HD860, there is
>   no this in kernel, I give you the patch for Montivisa, pls help me =
to analyze it. I had
>   configure it with the patch, but there is also no use. So I think I =
maybe omit a common feature
>   in kernel configuration. pls take a look at it.
>    thanks a lot!
>=20
>=20
> -----
