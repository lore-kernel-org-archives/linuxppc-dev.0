Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.201])
	by ozlabs.org (Postfix) with ESMTP id AAA0967E50
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 10:21:58 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so9367wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 02 Aug 2005 17:21:57 -0700 (PDT)
Message-ID: <9b7ca6570508021721773d06f0@mail.gmail.com>
Date: Wed, 3 Aug 2005 09:21:57 +0900
From: Daniel Ann <ktdann@gmail.com>
To: JohnsonCheng <johnsoncheng@qnap.com.tw>
In-Reply-To: <20050802114145.36B2667D77@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20050802114145.36B2667D77@ozlabs.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: A PPC kernel issue with UART ??
Reply-To: Daniel Ann <ktdann@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Johnson,

You know what? I've had the exact same problem only day or two ago. I
think the mail subject was "serial console" or something similar. Have
a read at it.

BTW, My problem was with interrupt setting.
Daniel.

On 8/2/05, JohnsonCheng <johnsoncheng@qnap.com.tw> wrote:
>=20
>=20
> Dear All,
>=20
> =20
>=20
> I meet a wired UART problem on linux-2.6 with MPC8241 chip.
>=20
> =20
>=20
> My Environment is as following:=20
>=20
> CPU: MPC8241
>=20
> Linux: 2.6.12.3
>=20
> COM1 offset: 0x4500, COM2 offset: 0x4600
>=20
> =20
>=20
> When I booting my rootfs, it hangs at following message:
>=20
> RAMDISK: Compressed image found at block 0
>=20
> VFS: Mounted root (ext2 filesystem) readonly.
>=20
> Freeing unused kernel memory: 104k init
>=20
> EXT2-fs warning: checktime reached, running e2fsck is recommended
>=20
> =20
>=20
> I had add printk in tty_write() of drivers/char/tty_io.c, the message fro=
m
> rootfs have printed.
>=20
> The conclusion is that message can be printed by printk() in linux kernel=
,
> but can't be printed by printf() in user mode. I think it must be somethi=
ng
> wrong for my UART configurations, does anybody know it??
>=20
> =20
>=20
> =20
>=20
> Best Regards,
>=20
> Johnson Cheng
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20


--=20
Daniel
