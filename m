Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Mon, 26 Aug 2002 20:40:16 +0800
From: leeyang <leeyang@ycig.com>
Subject: Re: linux booting
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <000901c24cfd$de617140$0141b73d@leeyang>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <20020825183517.4C07711822@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,WD
> There are some more hints at
> http://www.denx.de/doc/TQM8xxL/debugging.html

I have read it before,but only for module or application,
not for kernel and ppcboot,someone told me because of
ppcboot's relocation,so it is difficult in some externd.
Anyway it helps some:)

> > I want to watch r3,r4,r5,r6,r7 register when ppcboot transferring
> > to kernel.Could you tell me how to get that? thanks a lot!
>
> Start PPCBoot, setup bootargs etc., load  the  kernel  image.  Before
> finally typing the "bootm" command set a (hardware) breakpoint at the
> kernel entry point (= physical address 0x0000).
>
> When hitting the breakpoint, print the registers...

Yes,it works:),and I can check thoes regs when entering kernel.
and I am sure ppcboot handle correct value to kernel now.

the kernel can boot and I can see some in the console now.
I replaced the ppcboot.h in the 1.1.6 with one in old version
so I think it is still bdinfo problem.

However,new ones come:
kernel can not find init in the ramdisk!
the initrd had been tested in the old kernel and can mount fs
and entering system.so a little strange:(

the only reason I am wondering is the compiler!
the file in the initrd were compiled with HHL1.2 ppc compiler.
and the kernel was created with eldk.
Is that make sense?

leeyang


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
