Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id D06CFB6ED0
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 18:37:08 +1000 (EST)
Received: by iwn1 with SMTP id 1so2036887iwn.15
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 01:37:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <OF0E653CF5.2ED4C3A3-ONC1257751.002C6D6E-C1257751.002C903E@transmode.se>
References: <AANLkTinA2ghLxBU41aFAsLM1oXQ8HMASx1eQMDVvi56n@mail.gmail.com>
	<OF0E653CF5.2ED4C3A3-ONC1257751.002C6D6E-C1257751.002C903E@transmode.se>
Date: Tue, 29 Jun 2010 01:37:07 -0700
Message-ID: <AANLkTimZyozjYbQeQrR14oGCi3caqrox0JRPkJGp-lnS@mail.gmail.com>
Subject: Re: machine check in kernel for a mpc870 board
From: Shawn Jin <shawnxjin@gmail.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> =3D> bootm 1000000
>> ## Booting image at 01000000 ...
>> =A0 =A0Image Name: =A0 Linux-2.6.33.5
>> =A0 =A0Image Type: =A0 PowerPC Linux Kernel Image (gzip compressed)
>> =A0 =A0Data Size: =A0 =A0747319 Bytes =3D 729.8 kB
>> =A0 =A0Load Address: 00400000
>> =A0 =A0Entry Point: =A0004004d4
>
> Load and Entry Point should probably be 0

But the cuImage.adder875-uboot image also has the same load address as
mine and the entry point is 0x4004d8. Also cuImage.mpc885ads has the
same load address and entry point as cuImage.adder875-uboot. So I
don't suspect them.

All right. I built a uImage for mpc885ads and the uImage's load
address and entry point are both 0. So this is because I'm using
cuImage instead of uImage.

Thanks Joake, anyway.

-Shawn.
