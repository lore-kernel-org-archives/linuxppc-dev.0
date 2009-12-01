Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id D14511007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Dec 2009 10:10:25 +1100 (EST)
To: Allan Wang <aiyuanwang@yahoo.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: EP440XS board boot problem(Note:similart to Sequoia)
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <401793.31718.qm@web52903.mail.re2.yahoo.com>
References: <401793.31718.qm@web52903.mail.re2.yahoo.com>
Date: Wed, 02 Dec 2009 00:10:22 +0100
Message-Id: <20091201231022.AB72CE6D391@gemini.denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Allan Wang,

In message <401793.31718.qm@web52903.mail.re2.yahoo.com> you wrote:
>
> I am new to the list. I am still newbie to embedded linux. I have
> bought an ep440xs board which is similar to sequoia board. u-boot is
> working. I am trying to make it run linux. I have the following
> problems and need your help. Thank you very much:

Which exact version of U-Boot are you running on this board?

I guess this is a out-of-tree port, i. e. not part of the mainline
U-Boot repository - so are you sure that device tree support is
enabled in your version of U-Boot?
> 
> I am using linux kernel 2.6.30.4. I encounter 2 problems:
> 1. After console_init() is called inside start_kernel(), the console starts printing garbage like:
> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> serial8250.0: ttyS0 at MMIO 0x1ef600300 (irq = 16) is a 16550A
> ������������������������������
...

What is your exact boot command?

Which boot arguments do you pass to the kernel?

What is ytour console baud rate in U-Boot, and what sort of "console="
boot argument do you pass to the Linux kernel?

What does your device tree look like?


> 2. It pakics when mounting the root file system(NFS):
> (gdb) bt
> #0 panic (fmt=0xc0290e94 "VFS: Unable to mount root fs on %s")

So what is the "%s" argument here? Which sort of root file system are
you trying to mount - NFS, ramdisk, UBIFS, ... ?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"He only drinks when he gets depressed." "Why does he get depressed?"
"Sometimes it's because he hasn't had a drink."
                                     - Terry Pratchett, _Men at Arms_
