From: zjuzhou@163.net
MIME-Version: 1.0
Message-Id: <3AF75886.01661@bjapp2>
Date: Tue, 8 May 2001 10:23:02 +0800 (CST)
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: After add CONFIG_MODULES,it works noting?
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>Kim write:
> If you don't use driver as module, whenever you modify the driver you should compile the kernel.
> (I think it's one of the reasons why module is used)

	Maybe we can write programe controling simple hardware in user space not in kernel sapce.About KGDB ,does it need more device? Thanks.

	I still don't konw why after uncompressing kernel,it works noting.
But when I remove CONFIG_MODULES from config file,it works well again.When
arch/ppc/mbxboot/head.s give the control to init/main.c ,it will
display LINUX_BANNER information,but it do noting,I think serial port must
works well.My bootloader is pSOS's.

	thanks.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
